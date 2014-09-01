# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'theme_bandit/version'

Gem::Specification.new do |spec|
  spec.name          = "theme_bandit"
  spec.version       = ThemeBandit::VERSION
  spec.email         = ["lfender6445@gmail.com"]
  spec.authors       = ["Luke Fender"]
  spec.summary       = %q{Grab a site and all of its assets in a manageable way}
  spec.description   = %q{Download any sites assets and convert to rack app}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_dependency 'httparty',  '~> 0.11.0'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'html2slim'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
