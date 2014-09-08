# ThemeBandit

Enjoy rapid prototyping with theme bandit :heart:

Wordpress themes are beautiful! Now you can easily convert your favorite wordpress theme to a small ruby app.

This gem converts any site template (Wordpress, Joomla, HTML) into a small and
simple sinatra rack application, handling all of the JS and CSS for you.

Usage from the command line: `bandit`
- Select a url to download
- Select a templating engine (erb, haml, slim)
- Start your rack app!

## Installation

Add this line to your application's Gemfile:

    gem 'theme_bandit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install theme_bandit

## Usage
`bandit` -> Builds a rack application in the `theme` directory of
your project root.

## Caveats
Not all templating engines play nicely with html. If you run into
templating issues, `erb` will be your safest bet because it renders as
pure html.

## TODO
- Support for binaries (images + fonts + embeds)
- Support for multiple pages
- HTML Sanitization
- HTML Formatting

## Tests

```
rake test
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
