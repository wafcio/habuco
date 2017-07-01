require 'habuco/definition'
require 'habuco/version'

module Habuco
  module ClassMethods
    def attribute(name, value = nil)
      attribute_definitions[name] = Definition.new(name, value)
    end

    def attribute_definitions
      @attribute_definitions ||= {}
    end

    def build
      {}.tap do |h|
        attribute_definitions.each do |key, definition|
          value = definition.value
          h[key] = value.respond_to?(:call) ? value.call : value
        end
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end
