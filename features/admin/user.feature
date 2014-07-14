Feature:  User

  @development
  Scenario:  Login as ole-khuntley, then logout
    Given I am ole-khuntley
    When I login
    Then I am logged in
    And I logout
