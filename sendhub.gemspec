# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sendhub}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Taylor"]
  s.date = %q{2017-03-28}
  s.description = %q{sendhub is a Ruby client library for SendHub.net.}
  s.email = %q{moomerman@gmail.com}
  s.files = ["LICENSE", "README.textile","lib/sendhub.rb","lib/sendhub/ca.pem"] + Dir.glob('lib/sendhub/*.rb') + Dir.glob('lib/sendhub/plugins/*.rb')
  s.has_rdoc = false
  s.homepage = %q{https://sendhub.net/}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{sendhub}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{sendhub is a Ruby client library for SendHub.net.}

  if s.respond_to? :specification_version then
      current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
      s.specification_version = 2

      if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
        s.add_runtime_dependency(%q<json>, [">= 1.1.9"])
      else
        s.add_dependency(%q<json>, [">= 1.1.9"])
      end
    else
      s.add_dependency(%q<json>, [">= 1.1.9"])
    end
end
