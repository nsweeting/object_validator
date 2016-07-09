# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'object_validator/version'

Gem::Specification.new do |spec|
  spec.name          = "object_validator"
  spec.version       = ObjectValidator::VERSION
  spec.authors       = ["Nicholas Sweeting"]
  spec.email         = ["nsweeting@gmail.com"]

  spec.summary       = 'A lightweight validator for Plain Old Ruby Objects.'
  spec.description   = 'A lightweight validator for Plain Old Ruby Objects.'
  spec.homepage      = 'https://github.com/nsweeting/object_validator'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
