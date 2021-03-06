unless `bundle exec vagrant box list`.include?('precise64')
  fail 'Box is not added! Run "bundle exec rake features:bootstrap".'
end

require 'aruba/cucumber'

# Useful for debugging Vagrant issues
# ENV['VAGRANT_LOG'] = 'info'

Before do
  system 'cd tmp/aruba; bundle exec vagrant destroy -f'
  system 'cd tmp/aruba; rm -rf *.sh'
  # VM start takes a long time
  @aruba_timeout_seconds = 180
end

After do
  # halt VM
  system 'cd tmp/aruba; bundle exec vagrant destroy -f'
  system 'cd tmp/aruba; rm -rf *.sh'
end
