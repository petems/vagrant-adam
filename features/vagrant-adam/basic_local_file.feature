@no-clobber
Feature: vagrant-adam local file
  In order to check vagrant-adam is working
  As a user
  I should see issues with a basic smoke test

  Scenario:
    Given a Vagrantfile with a adam.provision_url of "./hello_world_local_file.sh"
    And a shell file 'hello_world_local_file.sh' with content of "echo 'Hello World!'"
    When I run `bundle exec vagrant up`
    Then the exit status should not be 1
    And the output should contain "Hello World"

  Scenario:
    Given a Vagrantfile with a adam.provision_url of "./fail_script.sh"
    And a shell file 'fail_script.sh' with content of "echo 'missing single quote"
    When I run `bundle exec vagrant up`
    Then the exit status should not be 0
    And the output should contain "Syntax error: Unterminated quoted string"

  Scenario:
    Given a Vagrantfile with a adam.provision_url of "./hello_world_local_file.sh"
    And a shell file 'hello_world_local_file.sh' with content of "echo 'Hello World!'"
    And the Vagrant box is already running
    Then the provision output should contain "Hello World"

  Scenario:
    Given a Vagrantfile with no adam.provision_url
    When I run `bundle exec vagrant up`
    Then the exit status should not be 1