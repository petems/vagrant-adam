# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-adam/version'

Gem::Specification.new do |spec|
  spec.name          = 'vagrant-adam'
  spec.version       = VagrantPlugins::Adam::VERSION
  spec.authors       = ['Peter Souter']
  spec.email         = ['p.morsou@gmail.com']
  spec.description   = 'A Vagrant plugin that runs a given provision script before any other tasks.  '
  spec.summary       = spec.description
  spec.homepage      = 'https://github.com/petems/vagrant-adam'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.test_files    = spec.files.grep(%w{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.1.1'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_development_dependency 'rubocop', '~> 0.17.0'
  spec.add_development_dependency 'coveralls', '~> 0.7.1'
  spec.add_development_dependency 'guard-rspec', '~> 4.3.1'
  spec.add_development_dependency 'terminal-notifier-guard', '~> 1.5.3'
  spec.add_development_dependency 'aruba', '~> 0.6.1'
end
