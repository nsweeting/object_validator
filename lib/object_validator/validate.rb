module ObjectValidator
  module Validate
    def valid?
      validator.valid?
    end

    def errors
      return Errors.new unless defined?(@validator)
      validator.errors
    end

    private

    def validator
      @validator ||= Object.const_get("#{self.class.name}Validator").new(self)
    end
  end
end
