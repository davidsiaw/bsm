# Bsm

Bsm allows you to write binary files in a human-readable way.

Bsm defines binary files like so:

```
41 42 43
```

is interpreted as

```
ABC
```

Bsm is very tolerant to spaces. Any whitespace is ignored as a separator. So if you have input like this:

```
41

42 43
```

Bsm will still output

```
ABC
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bsm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bsm

## Usage

### As a command line tool

Simply pipe a string of hexadecimals into bsm and receive the output in stdout

```
$ echo "41 42 43 0A" | bsm
ABC
```

Alternatively, give it a filename. Assune you have a file called `inputfile`, with the contents `41 42 43 44`

```
$ bsm inputfile
ABCD
```

### As a gem

Simply instantiate `Bsm::Generator`

```ruby
g = Bsm::Generator.new
puts g.generate('41 42 43')
# will result in ABC
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` and `markspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davidsiaw/bsm. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Bsm project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/davidsiaw/bsm/blob/master/CODE_OF_CONDUCT.md).
