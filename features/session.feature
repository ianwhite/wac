Feature: Simple query
  In order to get goin
  As a wa client
  I want to be able to ask for 'pi'

  Scenario: Get a Wac session with an appid
    When I ask for a session with appid: "key123"
    Then I should have a session with appid: "key123"
    
  Scenario: Set a default appid, and get a Wac session
    When I set the default appid: "key123"
    And I ask for a session
    Then I should have a session with appid: "key123"
