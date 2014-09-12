Given(/^a Vagrantfile with a adam\.provision_url of "(.*?)"$/) do |provision_url|

  file_content = <<EOS
require 'vagrant-adam'

Vagrant.configure("2") do |config|
  config.vm.define :ubuntu do |ubuntu|
    ubuntu.adam.provision_url = '#{provision_url}'
    ubuntu.vm.box = "precise64"
    ubuntu.vm.box_url = "http://files.vagrantup.com/precise64.box"
  end
end
EOS

  # Create file
  write_file('Vagrantfile', file_content)
end

Given(/^a shell file '(.*?)' with content of "(.*?)"$/) do |script_name, script_contents|

  file_content = <<EOS
#!/bin/sh -e
#{script_contents}
EOS

  # Create file
  write_file(script_name, file_content)
end

Given(/^a Vagrantfile with no adam\.provision_url$/) do
  file_content = <<EOS
require 'vagrant-adam'

Vagrant.configure("2") do |config|
  config.vm.define :ubuntu do |ubuntu|
    ubuntu.vm.box = "precise64"
    ubuntu.vm.box_url = "http://files.vagrantup.com/precise64.box"
  end
end
EOS

  # Create file
  write_file('Vagrantfile', file_content)
end

Given(/^the environment variable (.+) is nil$/) do |variable|
  set_env(variable, nil)
end

Given(/^the environment variable (.+) is "(.+)"$/) do |variable, value|
  set_env(variable, value)
end

Given(/^the Vagrant box is already running$/) do
  run_simple('bundle exec vagrant up')
end