# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'theme_bandit/util/version'

Gem::Specification.new do |spec|
  spec.name          = 'theme_bandit'
  spec.version       = ThemeBandit::VERSION
  spec.email         = ['lfender6445@gmail.com']
  spec.authors       = ['Luke Fender']
  spec.summary       = 'Convert any site to a simple rack app'
  spec.description   = 'Convert any site to a simple rack app'
  spec.homepage      = 'https://github.com/lfender6445/theme_bandit'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   << 'bandit'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_dependency 'httparty',  '~> 0.11.0'
  spec.add_dependency 'nokogiri',  '~> 1.6.3.1'
  spec.add_dependency 'html2slim', '~> 0.1.0'
  spec.add_dependency 'html2haml', '~> 1.0.1'
  spec.add_dependency 'css_parser', '~> 1.3.5'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.3.2'
  spec.add_development_dependency 'minitest', '~> 5.4.1'
  spec.add_development_dependency 'webmock', '~> 1.18.0'
end
