# https://codegolf.stackexchange.com/questions/166012/exchange-capitalization

Feature: Exchange capitalization
  Background:
    Given a file named "exchange-capitalization.⛳️" with:
      """golfmoji
      🔼🔄🔼⏩🔀⏩🔀⏫⏩⏫
      """

  Scenario: Output is correct.
    When I run `golfmoji -f exchange-capitalization.⛳️ CodeGolf xxPPCGxx`
    Then the output should contain exactly:
      """
      coDEGOlf XxppCgxx
      """
