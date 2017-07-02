require 'ostruct'

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

    def build(context = {})
      new(context).build
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  attr_reader :context

  def initialize(context = {})
    @context = OpenStruct.new(context)
  end

  def build
    {}.tap do |h|
      self.class.attribute_definitions.each do |key, definition|
        value = definition.value
        h[key] = value.respond_to?(:call) ? context.instance_exec(&value) : value
      end
    end
  end
end
