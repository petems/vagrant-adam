require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'cucumber/rake/task'
require 'yard'

YARD::Rake::YardocTask.new

namespace :test do

  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = "spec/unit/**/*_spec.rb"
  end

end

namespace :features do
  desc 'Downloads and adds vagrant box for testing.'
  task(:bootstrap) do
    system('bundle exec vagrant box add precise64 http://files.vagrantup.com/precise64.box')
  end

  Cucumber::Rake::Task.new(:run) do |t|
    t.cucumber_opts = %w(--format pretty)
  end
end

task :default => "test:unit"