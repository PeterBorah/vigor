Gem::Specification.new do |s|
  s.name        = 'vigor'
  s.version     = '0.1.0'
  s.date        = '2013-12-11'
  s.summary     = "Unofficial League of Legends API wrapper"
  s.description = "This aims to be a idiomatic Ruby wrapper for the League of Legends API. Very much a work in progress at the moment."
  s.authors     = ["Peter Borah"]
  s.email       = 'peterborah@gmail.com'
  s.files       = ["lib/vigor.rb"]
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/PeterBorah/vigor'
  s.test_files  = Dir.glob('spec/')
  s.add_runtime_dependency 'httparty'
  s.add_development_dependency 'rspec'
end
