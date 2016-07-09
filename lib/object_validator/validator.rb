module ObjectValidator
  module Validator
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      attr_reader :object, :errors

      def initialize(object)
        @object = object
        @errors = Errors.new
      end

      def valid?
        self.class.checks.each { |args| call_checks(*args) }
        @errors.all.empty?
      end

      private

      def call_checks(name, checks)
        checks.each do |check|
          klass = check.first.to_s.split('_').collect(&:capitalize).join
          klass = Object.const_get("ObjectValidator::Checks::#{klass}")
          klass.new(@object, @errors, name, check.last).call
        end
      end
    end

    module ClassMethods
      def validates(*args)
        create_check(args)
      end

      def checks
        @checks
      end

      private

      def create_check(args)
        @checks = [] unless defined?(@checks)
        @checks << args
      end
    end
  end

  module Checks
    class Base
      attr_accessor :object, :errors, :name, :value

      def initialize(object, errors, name, value)
        @object = object
        @errors = errors
        @name = name
        @value = value
      end

      def method
        @method ||= @object.send(@name)
      end
    end
  end
end
