FactoryGirl.define do
  factory :movie do
    title 'A Fake Title'
    rating 'PG'
    director 'A Crappy Director'
    release_date { 20.years.ago }
  end
end
