@no-clobber
Feature: vagrant-adam local file
  In order to check vagrant-adam is working
  As a user
  I should see issues with a basic smoke test

  Scenario:
    Given a Vagrantfile with a adam.provision_url of "./script.sh"
    And a shell file with content of "echo 'Hello World!'"
    When I run `bundle exec vagrant up`
    Then the exit status should not be 1
    And the output should contain "Hello World"

  Scenario:
    Given a Vagrantfile with a adam.provision_url of "./script.sh"
    And a shell file with content of "echo 'missing single quote"
    When I run `bundle exec vagrant up`
    Then the exit status should not be 0
    And the output should contain "Syntax error: Unterminated quoted string"