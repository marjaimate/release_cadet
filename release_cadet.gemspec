# -*- encoding: utf-8 -*-
require File.expand_path('../lib/release_cadet/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mate Marjai"]
  gem.email         = ["mate.marjai@sumup.com"]
  gem.summary       = %q{Release helper for our barnching structure.}
  gem.description   = %q{SumUp release managers best friend.}
  gem.homepage      = ""

  gem.files         = Dir.glob("lib/**/*.rb") + Dir.glob("bin/*") + Dir.glob("config/**/*") + ['release_cadet.gemspec']
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "release_cadet"
  gem.require_paths = ["lib"]
  gem.version       = ReleaseCadet::VERSION

  # Declare the gem dependecies
  gem.add_dependency('rake')
  gem.add_dependency('active_support')
end
