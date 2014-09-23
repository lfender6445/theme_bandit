# ThemeBandit

Enjoy rapid prototyping with theme bandit :heart:

Wordpress themes are beautiful - now you can easily convert your favorite themes to a small ruby app

This gem converts any site template (Wordpress, Joomla, HTML) into
simple sinatra rack application, resolving both javascript and css.

Usage from the command line: `bandit`

- Select a url to download
- Select a templating engine (erb, haml, slim)
- Start your rack app!

You wouldn't download a website ... would you?!

## Installation

Add this line to your application's Gemfile:

    gem 'theme_bandit', '~> 0.0.5'

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

Example: The gem converts html for page A to slim, erb, or haml.
Sometimes the html for page A is messy and in turn produces bad slim,
which can cause the application to blow up until corrected.

## TODO / Coming Soon
- _Replace & fetch @import declarations in CSS_ added in v0.0.5
- Support for binaries (images + fonts + embeds)
- Fetch ajax resources
- HTML Sanitization
- Support for multiple pages
- HTML Formatting
- Verfiy inline tags

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
