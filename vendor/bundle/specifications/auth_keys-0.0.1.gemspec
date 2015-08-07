# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "auth_keys"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["takuya"]
  s.date = "2015-08-07"
  s.description = "Password loads in ~/.auth_keys "
  s.email = ["takuy.a.1st+nospam@gmail.com"]
  s.homepage = "https://github.com/takuya/auth_key"
  s.licenses = ["GPL3"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Password loads in ~/.auth_keys"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.7"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.7"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.7"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
  end
end
