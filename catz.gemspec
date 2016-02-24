Gem::Specification.new do |s|
  s.name        = 'catz'
  s.version     = '0.0.0'
  s.date        = '2016-02-23'
  s.summary     = "Catz"
  s.description = "Cats... cats everywhere!"
  s.authors     = ["Abeer Salameh"]
  s.email       = 'abeer.salameh@gmail.com'
  s.files       = ["lib/catz.rb"]
  s.homepage    = 'http://github.com/cwrw/catz'
  s.license     = 'MIT'
  s.files       = ["README.md"] + Dir["lib/**/*.*"]
  s.executables = ["catz"]

  s.add_dependency "faraday", "~> 0.9"
  s.add_dependency "faraday_middleware", "~> 0.9"
  s.add_dependency "multi_xml", "~> 0.5"
  s.add_development_dependency "rake", "~> 10.5"
  s.add_development_dependency "rspec", "~> 3.4"
  s.add_development_dependency "rubocop", "~> 0.37"
  s.add_development_dependency "capybara", "~> 2.6"
  s.add_development_dependency "webmock", "~> 1.20"
  s.add_development_dependency "nokogiri", "~> 1.6"
  s.add_development_dependency "pry", "~> 0.10"
end
