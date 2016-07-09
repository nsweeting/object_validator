module ObjectValidator
  module Checks
    class With < Base
      def call
        fail unless value[:proc].call(object)
      rescue
        errors.add(name, value[:msg])
      end
    end
  end
end
