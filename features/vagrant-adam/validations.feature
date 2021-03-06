@no-clobber
Feature: vagrant-adam validations
  In order to avoid configuration mistakes for vagrant-adam commands
  As a user
  I should see proper validation errors

  Scenario: raises error if url of file doesnt exist
    Given a Vagrantfile with a adam.provision_url of "https://github.com/petems/vagrant-adam/this_file_doesnt_exist.sh"
    When I run `bundle exec vagrant up`
    Then the exit status should not be 0
    And the output should contain "The requested URL returned error: 404 Not Found"

  Scenario: raises error if url of file doesnt exist
    Given a Vagrantfile with a adam.provision_url of "https://@@@@@fakeurl...."
    When I run `bundle exec vagrant up`
    Then the exit status should not be 0
    And the output should contain "'https://@@@@@fakeurl....' is not a valid URL"

  Scenario: raises error if path of file doesnt exist
    Given a Vagrantfile with a adam.provision_url of "/tmp/foo_bar_baz.sh"
    When I run `bundle exec vagrant up`
    Then the exit status should not be 0
    And the output should contain "File '/tmp/foo_bar_baz.sh' could not be found."

  Scenario:
    Given a Vagrantfile with no adam.provision_url
    And the environment variable PRE_PROV_URL is "/tmp/foo_bar_baz.sh"
    When I run `bundle exec vagrant up`
    Then the exit status should not be 0
    And the output should contain "Couldn't open file /tmp/foo_bar_baz.sh"