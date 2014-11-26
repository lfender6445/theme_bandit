# theme_bandit

Enjoy rapid prototyping with theme bandit :heart:

Wordpress themes are beautiful - now you can easily convert your favorite themes to a small ruby app

This gem converts any site template (Wordpress, Joomla, HTML) into a
simple [sinatra](http://www.sinatrarb.com/) rack application.

Usage from the command line: `bandit`

- Select a url to download
- Select a templating engine (erb, haml, slim)
- Start your rack app!

You wouldn't download a website ... would you?!

## CLI usage
`bandit` -> Builds a rack application in a `theme` directory of
your current working directory.

## TODO / Coming Soon
- Support for binaries (images + fonts + embeds)
- Fetch asynchronous resources
- Support for multiple pages

## template issues
Not all templating engines play nicely with html. If you run into
templating issues, `erb` will be your safest bet because it renders as
pure html.

Example: The gem converts html for page A to slim, erb, or haml.
If the html for page A is messy, it will produce bad slim
and cause the application to blow up until adjusted.

## installation

Add this line to your application's Gemfile:

    gem 'theme_bandit', '~> 0.0.7'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install theme_bandit


## tests

```
bundle exec rake test
```
## contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
