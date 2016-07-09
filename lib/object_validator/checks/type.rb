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
