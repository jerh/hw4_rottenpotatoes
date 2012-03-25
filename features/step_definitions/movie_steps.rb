Given /^the following movies exist:$/ do |movies_table|
  movies_table.hashes.each do |movie|
    attributes = {}
    movie.each { |attr,value| attributes[attr.to_sym] = value }
    Movie.create attributes 
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2| 
  assert_not_nil page.body =~ /#{e1}.+#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(/,\s?/).each do |rating|
    if uncheck
      step %Q{I uncheck "ratings_#{rating}"}
    else
      step %Q{I check "ratings_#{rating}"}
    end 
  end 
end

Then /^I should see all of the movies$/ do
  movies = Movie.all.map(&:title)
  assert_equal page.all('table#movies tbody tr').count, movies.length
  movies.each do |movie|
    step %Q{I should see "#{movie}"}
  end 
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie, director|
  Movie.find_by_title(movie).director.should == director
end
