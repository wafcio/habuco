require 'ostruct'

require 'habuco/definition'
require 'habuco/version'

module Habuco
  module ClassMethods
    def attribute(name, value = nil)
      namespace = namespace_scope.dup
      attribute_definitions[name] = Definition.new(name, value, namespace)
    end

    def attribute_definitions
      @attribute_definitions ||= {}
    end

    def namespace(name)
      namespace_scope.push(name)
      yield
      namespace_scope.pop
    end

    def namespace_scope
      @namespace_scope ||= []
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
    {}.tap do |data|
      self.class.attribute_definitions.each do |key, definition|
        val = definition.value
        d = definition.namespace.inject(data) { |h, k| h[k] ||= {} }
        d[key] = val.respond_to?(:call) ? context.instance_exec(&val) : val
      end
    end
  end
end
