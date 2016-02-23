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

  s.add_development_dependency "rake", "~> 10.5"
  s.add_development_dependency "rspec", "~> 3.4"
  s.add_development_dependency "rubocop", "~> 0.37"
  s.add_development_dependency "capybara"
  s.add_development_dependency "webmock"
  s.add_development_dependency "nokogiri"
end
