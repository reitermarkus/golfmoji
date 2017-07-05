Feature: Hello world!
  Background:
    Given a file named "average-of-array.⛳️" with:
      """golfmoji
      📃🗜➗➕
      """

  Scenario: Output is correct.
    When I run `golfmoji -f average-of-array.⛳️ [2,6,7]`
    Then the output should contain exactly:
      """
      5.0
      """
