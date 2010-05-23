Feature: See Homepage
  In order to verify loading of homepage
  As Dan
  I want to see the homepage

  Scenario: Load the homepage
    Given That I am "Dan"
    When I am on the homepage
    Then I should see "SV Rails Conf"
    And I should see the png: svtrain.png
    And On LHS I should see links: "Home Program Venue Speakers Registration"
