module ObjectValidator
  module Checks
    class Keys < Base
      def call
        return if method.is_a?(Hash) &&
                  value.each { |key| break false unless method.key?(key) }
        errors.add(name, 'does not contain required Hash keys')
      end
    end
  end
end
