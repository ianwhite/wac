Feature: Simple query
  In order to get goin
  As a wa client
  I want to be able to ask for 'pi'

  Scenario: Get a Wac session with an appid
    When I ask for a session with appid: "key123"
    Then I should have a session with appid: "key123"
