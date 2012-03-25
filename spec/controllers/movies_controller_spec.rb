require 'spec_helper'

describe MoviesController do
  describe 'adding director to existing movie' do
    before :each do
      @movie = FactoryGirl.create(:movie)
      put :update, :id => @movie.id, :movie => {:director => 'Some Director'}
    end

    it 'should pass params to movie item when update director' do
      assigns[:movie].director.should == 'Some Director'
    end

    it 'should redirect to movie detail page when movie is updated' do
      response.should redirect_to(@movie)
    end
    
  end

  describe 'find movie with same director where director exists' do
    before :each do
      @movie1 = FactoryGirl.create(:movie)
      @movie2 = FactoryGirl.create(:movie, :title => 'A Fake Title: The Sequel')
    end

    it 'should call the model method that performs search for similar director' do
      Movie.should_receive(:find_all_by_director).with(@movie1.director).and_return([@movie1, @movie2])
      get :similar, :id => @movie1.id
    end

    describe 'found movies with same director' do
      before :each do
        get :similar, :id => @movie1.id
      end

      it 'should render Show page template' do
        response.should render_template('similar')
      end

      it 'should make movies with same director results available to template' do
        assigns[:movies].should == [@movie2]
      end
    end
  end

  describe 'find movie with same director where director is nil' do
    before :each do
      @movie = FactoryGirl.create(:movie, :director => nil)
    end

    it 'should not call the model method that performs search for similar director' do
      Movie.should_not_receive(:find_all_by_director)
      get :similar, :id => @movie.id
    end

    describe 'movie has no director info' do
      before :each do
        get :similar, :id => @movie.id
      end

      it 'should rendex Index page template' do
        response.should redirect_to('/movies')
      end
      
      it 'should make error message available to template' do
        flash[:notice].should == "'#{@movie.title}' has no director info"
      end
    end
  end
end 
