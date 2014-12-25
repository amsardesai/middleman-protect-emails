# middleman-protect-emails

**middleman-protect-emails** is a [Middleman](http://middlemanapp.com) extension that encrypts email links on your page on the server-side and decodes them on the client-side, cleanly avoiding spam bots with no visible impacts to your users.

This gem makes use of a simple [ROT13](http://en.wikipedia.org/wiki/ROT13) encryption algorithm to encrypt email links. Users must have Javascript enabled on their computers for the decoding stage to work.

## Installation

Add this line to your Middleman application's Gemfile:

```ruby
gem 'middleman-protect-emails'
```

And then execute:

  $ bundle

## Configuration

Installation is as simple as adding the following line to your project's `config.rb` file:

```ruby
# config.rb
activate :protect_emails
```

You can also add it to your build-specific configuration:

```ruby
# config.rb
configure :build do
  activate :protect_emails
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a [new pull request](../../pull/new/master)
