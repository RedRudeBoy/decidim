# frozen_string_literal: true
$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../decidim-core/lib/decidim/core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Decidim.add_default_gemspec_properties(s)

  s.name        = "decidim-dev"
  s.summary     = "Decidim Dev tools"
  s.description = "Utilities and tools we need to develop Decidim"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "LICENSE.txt", "Rakefile", "README.md"]

  s.add_dependency "factory_girl_rails"
  s.add_dependency "database_cleaner", "~> 1.5.0"
  s.add_dependency "capybara", "~> 2.10.0"
  s.add_dependency "capybara-screenshot", "~> 1.0.14"
  s.add_dependency "rspec-rails", "~> 3.5"
  s.add_dependency "rspec-repeat", "~> 1.0.2"
  s.add_dependency "byebug"
  s.add_dependency "wisper-rspec"
  s.add_dependency "listen", "~> 3.1.0"
  s.add_dependency "launchy"
  s.add_dependency "i18n-tasks", "~> 0.9.6"
  s.add_dependency "bullet", "~> 5"
  s.add_dependency "faker", "~> 1.6.6"
  s.add_dependency "poltergeist", "~> 1.11.0"
  s.add_dependency "rails-controller-testing", "~> 1.0.1"
  s.add_dependency "simplecov", "~> 0.12"
  s.add_dependency "codecov", "~> 0.1.9"
  s.add_dependency "rubocop", "~> 0.45"
end
