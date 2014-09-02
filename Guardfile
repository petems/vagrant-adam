guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/vagrant-adam/(.+)\.rb$}) { |m| "spec/unit/vagrant-puppet-install/#{m[1]}_spec.rb" }
  watch('spec/unit/spec_helper.rb')  { 'spec' }
end
