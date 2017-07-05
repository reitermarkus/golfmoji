Feature: Explode, copy, and zip.
  Background:
    Given a file named "explode-copy-zip.⛳️" with:
      """golfmoji
      ⛳️💥©🎗
      """

  Scenario: Output is correct.
    When I run `golfmoji -f explode-copy-zip.⛳️`
    Then the output should contain exactly:
      """
      [["H", "H"], ["e", "e"], ["l", "l"], ["l", "l"], ["o", "o"], [" ", " "], ["w", "w"], ["o", "o"], ["r", "r"], ["l", "l"], ["d", "d"], ["!", "!"]]
      """
