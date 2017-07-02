# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mumukit/inspection/version'

Gem::Specification.new do |spec|
  spec.name          = 'mumukit-inspection'
  spec.version       = Mumukit::Inspection::VERSION
  spec.authors       = ['Franco Leonardo Bulgarelli']
  spec.email         = ['flbulgarelli@yahoo.com.ar']
  spec.summary       = 'Minimal library for parsing Mumuki inspection language'
  spec.homepage      = ""
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'mumukit-core', '>= 0.1', '< 2'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '2.13'
  spec.add_development_dependency 'codeclimate-test-reporter'

end
