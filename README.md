# ObjectValidator

[![Code Climate](https://codeclimate.com/github/nsweeting/object_validator/badges/gpa.svg)](https://codeclimate.com/github/nsweeting/object_validator)

ObjectValidator is a set of simple module mixins for validating Plain Old Ruby Object data. A lightweight alternative to ActiveModel. As of now it has small set of validations - but these are easily extensible.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'object_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install object_validator

## Usage

To include validation on an object, we must do:

```ruby
include ObjectValidator::Validate
```

So, given a Person object, we would have:

```ruby
class Person
  include ObjectValidator::Validate

  attr_accessor :name, :email, :details, :age, :uri
end
```

We must then create an accompanying Validator object. The Validator object must be named appropriately. This is simply the name of the object in question, with the addition of 'Validator'. With our Person object, it would look like this.

```ruby
class PersonValidator
  include ObjectValidator::Validator

  validates :name, presence: true, type: String
  validates :details, keys: [:number, :street, :phone]
  validates :age, greater_than: 0
  validates :uri, with: { proc: proc { |p| p.uri.length > 5 }, msg: 'is too short' }
end
```

With this, we can now do the following with our Person object.

```ruby
person = Person.new
person.valid? => false
person.errors => #<ObjectValidator::Errors:0x0055b508b1b9b8 @all={:name=>["must not be Nil", "must be a String"], :details=>["does not contain required Hash keys"], :age=>["value is less than required"], :uri=>["is too short"]}>
person.errors.full_messages = > ["Name must not be Nil.", "Name must be a String.", "Details does not contain required Hash keys.", "Age value is less than required.", "Uri is too short."]
```

As of now, the following validations are available:

#### Presence
Checks whether the attribute is nil or empty.

```ruby
validates :example, presence: true
```

#### Type
Checks whether the attribute is of a certain type.

```ruby
validates :example, type: String
```

#### Keys
Checks whether the attribute is a Hash and contains certain keys.

```ruby
validates :example, keys: [:number, :street, :phone]
```

#### Greater Than
Checks whether the attribute is Numeric and greater than a value.

```ruby
validates :example, greater_than: 0
```

#### With
A general purpose validator. The proc will be run, and a returned value of true will result in a pass. The proc will be passed the object being validated. You must also assign a custom message.

```ruby
validates :example, with: { proc: proc { |e| e.example.length > 5 }, msg: 'is too short' }
```

## Adding Validations

You can easily add more validations. Simply create a new class within ObjectValidator::Checks. The name of the class represents the key that can be used for validation. Within the check, you will have access to the following:

* name - The symbol of the attribute being validated.
* method - The attribute being validated.
* value - The value that is passed to the check.
* errors - The error object for the object we are validating.

For example, this is the Type check.

```ruby
module ObjectValidator
  module Checks
    class Type < Base
      def call
        return if method.is_a?(value)
        errors.add(name, "must be a #{value.name}")
      end
    end
  end
end
```

Simply return if the check passes. Otherwise, we can add a new error.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/object_validator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
