Feature: add new movie to listing

  As a movie producer
  So that my movie will be available in the listing
  I want to add new movies

Scenario: add new movie
  Given I am on the RottenPotatoes home page
  When I follow "Add new movie"
  Then I should be on the New movie page
  And I fill in "Title" with "Aladdin"
  And I select "G" from "Rating"
  And I press "Save Changes"
  Then I should be on the home page
  And I should see "Aladdin was successfully created."
