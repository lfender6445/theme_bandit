# ruby '1.9.3'
source 'https://rubygems.org'

# Specify your gem's dependencies in theme_bandit.gemspec
gemspec

r_version = RUBY_VERSION.to_f

group :development do
  if r_version > 2
    gem 'pry-byebug'
  else
    gem 'pry-debugger'
  end
end
