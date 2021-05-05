Gem::Specification.new do |s|
  s.name        = 'pokemon-iv-calculator'
  s.version     = '1.0.0'
  s.summary     = "Calculate Pokemons IVs from the Command Line! No support for EVs."
  s.description = "A simple command line tool to Calculate Pokemons IVs."
  s.authors     = ["Matt Jarnevic"]
  s.email       = 'matt.jarnevic@wpengine.com'
  s.files       = Dir.glob("lib}/**/*") + %w(LICENSE README.md)
  s.homepage    = 'https://rubygems.org/gems/pokemon-iv-calculator'
  s.license     = 'MIT'
end