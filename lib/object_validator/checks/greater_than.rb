module ObjectValidator
  module Checks
    class GreaterThan < Base
      def call
        return if method.is_a?(Numeric) && method > value
        errors.add(name, 'value is less than required')
      end
    end
  end
end
