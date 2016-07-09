module ObjectValidator
  module Validate
    def valid?
      @validator = validator_klass.new(self)
      @validator.valid?
    end

    def errors
      return Errors.new unless defined?(@validator)
      @validator.errors
    end

    private

    def validator_klass
      @validator_klass ||= Object.const_get("#{self.class.name}Validator")
    end
  end
end
