module ObjectValidator
  module Checks
    class Presence < Base
      def call
        presence = !method.nil? || method.respond_to?(:empty?) && !method.empty?
        return if value == presence
        errors.add(name, 'must not be Nil') if value
        errors.add(name, 'must be Nil') unless value
      end
    end
  end
end
