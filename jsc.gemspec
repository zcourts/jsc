Gem::Specification.new do |s|
  s.name        = 'jekyll-scientific'
  s.version     = File.open('VERSION').first
  s.authors     = ['Courtney Robinson']
  s.email       = ['jsc@crlog.info']
  s.description = %q{A group of plugins that make Jekyll sites easier for research publications. Includes support for LateX formulas and citations}
  s.summary     = %q{Adds LateX features to a Jekyll site.}
  s.homepage    = 'https://github.com/zcourts/jsc'
  s.license     = 'BSD3'

  s.platform         = Gem::Platform::RUBY
  s.rubygems_version = %q{1.3.6}
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=

  s.add_development_dependency('jekyll-scholar', '~> 1.2.3')
  s.add_development_dependency('liquid', '~> 2.5.2')
  s.add_development_dependency('rdoc', '> 0')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end