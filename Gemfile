source 'https://rubygems.org'

gemspec

group :development do
  # We depend on Vagrant for development, but we don't add it as a
  # gem dependency because we expect to be installed within the
  # Vagrant environment itself using `vagrant plugin`.
  gem 'vagrant', git: 'git://github.com/mitchellh/vagrant.git', tag: 'v1.4.3'
  gem 'cucumber', git: 'https://github.com/cucumber/cucumber.git', tag: 'v2.0.0.beta.2'
  gem 'cucumber-core', git: 'https://github.com/cucumber/cucumber-core.git', tag: 'v1.0.0.beta.2'
end

group :acceptance do
  gem 'vagrant-digitalocean', '~> 0.5.3'
  gem 'vagrant-aws', '~> 0.4.0'
  gem 'vagrant-rackspace', '~> 0.1.4'
end

group :docs do
  gem 'yard', '~> 0.8.5'
  gem 'redcarpet', '~> 2.2.2'
  gem 'github-markup', '~> 0.7.5'
end
