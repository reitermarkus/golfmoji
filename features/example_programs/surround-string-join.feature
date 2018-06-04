Feature: Surround strings with string and join them.
  Background:
    Given a file named "surround-string-join.⛳️" with:
      """golfmoji
      ⛳️💥'✉️🔗
      """

  Scenario: Output is correct.
    When I run `golfmoji -f surround-string-join.⛳️`
    Then the output should contain exactly:
      """
      'H''e''l''l''o'' ''w''o''r''l''d''!'
      """
