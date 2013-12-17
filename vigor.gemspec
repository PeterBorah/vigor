Gem::Specification.new do |s|
  s.name        = 'vigor'
  s.version     = '0.5.0'
  s.date        = '2013-12-16'
  s.summary     = 'Unofficial League of Legends API wrapper'
  s.description = 'This aims to be a idiomatic Ruby wrapper for the League of Legends API. Moving quickly toward 1.0.0!'
  s.authors     = ['Peter Borah']
  s.email       = 'peterborah@gmail.com'
  s.files       = Dir.glob('lib/**/*')
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/PeterBorah/vigor'
  s.test_files  = Dir.glob('spec/**/*')
  s.add_runtime_dependency 'httparty', '~> 0.12'
  s.add_development_dependency 'rspec', '~> 2.14'
  s.add_development_dependency 'vcr', '~> 2.8'
  s.add_development_dependency 'webmock', '~> 1.16'
end
