require 'test_helper'

class ObjectValidatorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ObjectValidator::VERSION
  end

  def test_basic_person_passes
    person = Person.new
    assert person.valid?
    assert person.errors.all.empty?
  end

  def test_presence_true_check
    person = Person.new
    person.name = nil
    refute person.valid?
    assert person.errors.all.key?(:name)
    byebug
  end

  def test_presence_false_check
    person = Person.new
    person.blank_var = 'Hello!'
    refute person.valid?
    assert person.errors.all.key?(:blank_var)
  end

  def test_type_check
    person = Person.new
    person.test_string = 10
    refute person.valid?
    assert person.errors.all.key?(:test_string)
  end
end
