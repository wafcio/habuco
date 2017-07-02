# Habuco

Habuco name come from HAsh BUilder with COntext.

It allows to use DSL to create hash structure with passed context.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'habuco'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install habuco

## Usage

### Static value

```ruby
class HashBuilder
  include Habuco

  attribute :foo, :bar
end

HashBuilder.build # => { foo: :bar }
```

### Date and Time value

```ruby
class HashBuilder
  include Habuco

  attribute :date, -> { Date.new(2000) }
end

HashBuilder.build # => { date: #<Date: 2000-01-01 ((2447893j,0s,0n),+0s,2299161j)> }
```

### Value with context

```ruby
class HashBuilder
  include Habuco

  attribute :foo, -> { user_name }
end

HashBuilder.build(user_name: 'John') # => { foo: 'John' }
```

### Namespace

```ruby
class HashBuilder
  include Habuco

  namespace :foo do
    attribute :bar, :foobar
  end
end

HashBuilder.build # => { foo: { bar: :foobar } }
```

### Dynamic key

```ruby
class HashBuilder
  include Habuco

  attribute -> { :"foo_#{n}" }, :bar
end

HashBuilder.build(n: 123) # => { foo_123: :bar }
```

### Collection

```ruby
class HashBuilder
  include Habuco

  each_with_index -> { collection } do |val, index|
    attribute :"foo_#{index}", val
  end
end

HashBuilder.build(collection: %i[red green blue]) # => { foo_0: :red, foo_1: :green, foo_2: :blue }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wafcio/habuco.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

