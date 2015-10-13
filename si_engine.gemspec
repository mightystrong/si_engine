$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "si_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "si_engine"
  s.version     = SiEngine::VERSION
  s.authors     = ["Michael Price"]
  s.email       = ["mike@mightystrongmedia.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SiEngine."
  s.description = "TODO: Description of SiEngine."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
end
