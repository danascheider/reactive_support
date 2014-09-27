require File.expand_path('../version.rb', __FILE__)
require File.expand_path('../files.rb', __FILE__)

Gem::Specification.new do |s|
  s.specification_version     = 1 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.required_ruby_version     = '>= 1.9.3'

  s.name                      = 'reactive_support'
  s.version                   = ReactiveSupport.gem_version
  s.date                      = '2014-09-24'

  s.description = "ActiveSupport methods re-implemented independently of the Rails ecosystem"
  s.summary     = "ReactiveSupport provides useful ActiveSupport methods in a gem that is simple, stable, agnostic, and transparent."

  s.authors                   = ["Dana Scheider"]
  s.email                     = "dana.scheider@gmail.com"

  # = MANIFEST =
  s.files                     = ReactiveSupport.files
  s.require_path              = 'lib'
  # = MANIFEST =

  s.test_files                = s.files.select {|path| path =~ /^spec\/.*.rb/ }
  s.licenses                  = 'MIT'

  s.extra_rdoc_files          = %w[CONTRIBUTING.md README.md LICENSE]

  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'bundler', '~> 1.6'
  s.add_development_dependency 'coveralls', '~> 0.7'
  s.add_development_dependency 'simplecov', '~> 0.9'

  s.has_rdoc         = true
  s.homepage         = "http://github.com/danascheider/reactive_support"
  s.rdoc_options     = ["--line-numbers", "--inline-source", "--title", "ReactiveSupport"]
  s.require_paths    = %w[lib]
  s.rubygems_version = '1.1.1'
end
