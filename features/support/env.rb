unless `bundle exec vagrant box list`.include?('precise64')
  raise 'Box is not added! Run "bundle exec rake features:bootstrap".'
end

require 'aruba/cucumber'
ENV['VAGRANT_LOG'] = 'info'

Before do
  system 'cd tmp/aruba; bundle exec vagrant destroy -f'
  # VM start takes a long time
  @aruba_timeout_seconds = 180
end

After do
  # halt VM
  system 'cd tmp/aruba; bundle exec vagrant destroy -f'
end
