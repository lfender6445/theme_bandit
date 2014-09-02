# ThemeBandit

Convert any site template (Wordpress, Joomla, etc) into a rack
application.

`./bin/bandit`

## Installation

Add this line to your application's Gemfile:

    gem 'theme_bandit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install theme_bandit

## Usage

- `theme init`
  - displays awesome ascii art
  - creates a dir named `./theme` if it does exist
  - created dir is ignored by git if file exists
  - prompts user for theme domain they want to steal
  - grab all html css and javascripts

## Contributing

1. Fork it ( https://github.com/[my-github-username]/theme_bandit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
