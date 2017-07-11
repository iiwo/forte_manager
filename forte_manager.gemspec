$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'forte_manager/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'forte_manager'
  s.version     = ForteManager::VERSION
  s.authors     = ['Iwo Dziechciarow']
  s.email       = ['iiwo@o2.pl']
  s.homepage    = 'https://github.com/ArcadiaPower'
  s.summary     = 'ForteManager'
  s.description = 'ForteManager'
  s.license     = 'MIT'
  s.required_ruby_version = '~> 2.0'

  s.files = Dir["{app,config,db,lib}/**/*", 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails'
  s.add_dependency 'fortenet', '~> 3.0'
  s.add_dependency 'haml-rails'
  s.add_dependency 'kaminari'
  s.add_dependency 'bootstrap-kaminari-views'
  s.add_dependency 'simple_form'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'filterrific'
  s.add_dependency 'api-pagination'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'sqlite3'
end
