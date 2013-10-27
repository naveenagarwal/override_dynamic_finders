# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'override_active_record_dynamic_finders/version'

Gem::Specification.new do |spec|
  spec.name          = "override_active_record_dynamic_finders"
  spec.version       = OverrideActiveRecordDynamicFinders::VERSION
  spec.authors       = ["Naveen Agarwal"]
  spec.email         = ["naveenagarwal287@gmail.com"]
  spec.description   = %q{Overrides dynamic finders in ActiveRecord module to use new Activerecord relation metho}
  spec.summary       = %q{Overrides dynamic finders in ActiveRecord module to use new Activerecord relation metho}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
