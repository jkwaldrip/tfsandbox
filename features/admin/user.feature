Feature:  User

  Scenario:  Login as a valid user then logout
    Given I am a user
    When I login
    Then I am logged in
    And I logout
