require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'cucumber/rake/task'
require 'yard'

YARD::Rake::YardocTask.new

namespace :test do

  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = 'spec/unit/**/*_spec.rb'
  end

end

namespace :style do
  require 'rubocop/rake_task'
  desc 'Run Ruby style checks'
  Rubocop::RakeTask.new(:ruby) do |task|
    task.patterns = [
      '**/*.rb',
      '**/Vagrantfile',
      '*.gemspec',
      'Gemfile',
      'Rakefile'
    ]
  end
end

namespace :features do
  desc 'Downloads and adds vagrant box for testing.'
  task(:bootstrap) do
    if `bundle exec vagrant box list`.include?('precise64.box')
      puts 'precise64 box found! No bootstrap needed.'
    else
      system('bundle exec vagrant box add precise64 http://files.vagrantup.com/precise64.box')
    end
  end

  Cucumber::Rake::Task.new(:run) do |t|
    t.cucumber_opts = %w(--format pretty --order random)
  end
end

task default: [
  'test:unit',
  'style:ruby'
]
