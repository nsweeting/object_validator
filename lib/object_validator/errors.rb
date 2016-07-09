module ObjectValidator
  class Errors
    attr_accessor :all

    def initialize
      @all = {}
      @full_messages = []
    end

    def add(name, msg)
      (@all[name] ||= []) << msg
    end

    def full_messages
      @all.map do |error|
        attr, errors = *error
        errors.each { |e| @full_messages << "#{attr.to_s.capitalize} #{e}." }
      end
      @full_messages
    end
  end
end
