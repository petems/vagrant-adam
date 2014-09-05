@no-clobber
Feature: vagrant-adam local file
  In order to allow use of environment variables
  As a user
  I should be able to set an environment path from the commandline

  Scenario:
    Given a Vagrantfile with no adam.provision_url
    And a shell file 'env_shell_script.sh' with content of "echo 'Hello World!'"
    And the environment variable PRE_PROV_URL is "./env_shell_script.sh"
    When I run `bundle exec vagrant up`
    Then the exit status should not be 1
    And the output should contain "Hello World"