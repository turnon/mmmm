# Mmmm

a helper to check method source_location in irb

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mmmm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mmmm

## Usage

Add this line to your .irbrc:

```ruby
require 'mmmm'
```

To check specific method source_location:

```ruby
mmmm Array.new, :extract_options!
```

To check all method source_location:

```ruby
mmmm Array.new
```

### Rename the helper

if `mmmm` is defined for another method, or you want a shorter accessor (for example, `m`):

```ruby
Mmmm.helper :m
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

