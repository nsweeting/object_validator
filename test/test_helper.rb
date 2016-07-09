$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'object_validator'

require 'minitest/autorun'

class PersonValidator
  include ObjectValidator::Validator

  validates :name, presence: true
  validates :test_string, type: String
  validates :details, keys: [:number, :street, :phone]
  validates :age, greater_than: 0
  validates :blank_var, presence: false
  validates :name, with: { proc: proc { |p| p.name = 'Billy Bob'},
                           name: 'is not Billy Bob' }
end

class Person
  include ObjectValidator::Validate

  attr_accessor :name, :email, :details, :age, :uri, :blank_var, :test_string

  def initialize
    @name = 'Billy Bob'
    @email = 'billy@bob.com'
    @details = { number: 10, street: 'Test Ave.', phone: '123-456-7890'}
    @age = 30
    @blank_var = nil
    @test_string = 'Hello!'
  end
end
