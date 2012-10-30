# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'palmister/version'

Gem::Specification.new do |gem|
  gem.name          = 'palmister'
  gem.version       = Palmister::VERSION
  gem.authors       = ['Dmitriy Kiriyenko']
  gem.email         = ['dmitriy.kiriyenko@anahoret.com']
  gem.description   = %q{Modern supportable rails diff}
  gem.summary       = %q{Modern supportable rails diff. Works on my machine.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'diff-lcs', '~> 1.1.3'
  gem.add_dependency 'erubis', '~> 2.7.0'
  gem.add_dependency 'nokogiri', '~> 1.5.5'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
