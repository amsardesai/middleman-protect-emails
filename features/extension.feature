Feature: Protect Emails

  Scenario: Replaces email addresses with hash
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :protect_emails
      """
      Given the Server is running at "test-app"
      When I go to "/"
      Then I should see:
      """

      """
