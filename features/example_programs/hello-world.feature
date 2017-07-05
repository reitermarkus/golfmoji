Feature: Hello world!
  Background:
    Given a file named "hello-world.⛳️" with:
      """golfmoji
      ⛳️
      """

  Scenario: Output is correct.
    When I run `golfmoji -f hello-world.⛳️`
    Then the output should contain exactly:
      """
      Hello world!
      """
