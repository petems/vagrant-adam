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

Given(/^a shell file with content of "(.*?)"$/) do |script_contents|

  file_content = <<EOS
#!/bin/sh -e
#{script_contents}
EOS

  # Create file
  write_file('script.sh', file_content)
end
