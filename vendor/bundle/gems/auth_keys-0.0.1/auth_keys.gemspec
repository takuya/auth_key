# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'auth_keys/version'

Gem::Specification.new do |spec|
  spec.name          = "auth_keys"
  spec.version       = AuthKey::VERSION
  spec.authors       = ["takuya"]
  spec.email         = ["takuy.a.1st+nospam@gmail.com"]
  spec.summary       = %q{Password loads in ~/.auth_keys }
  spec.description   = %q{Password loads in ~/.auth_keys } 
  spec.homepage      = "https://github.com/takuya/auth_key"
  spec.license       = "GPL3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
