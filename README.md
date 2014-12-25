# middleman-protect-emails

[![Build Status](https://travis-ci.org/amsardesai/middleman-protect-emails.svg)](https://travis-ci.org/amsardesai/middleman-protect-emails)
[![Code Climate](https://codeclimate.com/github/amsardesai/middleman-protect-emails/badges/gpa.svg)](https://codeclimate.com/github/amsardesai/middleman-protect-emails)
[![Test Coverage](https://codeclimate.com/github/amsardesai/middleman-protect-emails/badges/coverage.svg)](https://codeclimate.com/github/amsardesai/middleman-protect-emails)

**middleman-protect-emails** is a [Middleman](http://middlemanapp.com) extension that encrypts email links on your page on the server-side and decodes them on the client-side, avoiding spam bots with no visible impacts to your users.

This gem makes use of the [ROT13](http://en.wikipedia.org/wiki/ROT13) encryption algorithm to encrypt email links. Users must have Javascript enabled on their computers for the decoding stage to work.

## Installation

Add this line to your Middleman application's Gemfile:

```ruby
gem 'middleman-protect-emails'
```

And then run:

    $ bundle

## Usage

Using this gem is as simple as adding the following line to your project's `config.rb` file:

```ruby
activate :protect_emails
```

And that's it! This will now protect all `mailto` links in your Middleman project. 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a [new pull request](../../pull/new/master)
