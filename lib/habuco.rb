require 'ostruct'

require 'habuco/attribute_definition'
require 'habuco/each_definition'
require 'habuco/version'

module Habuco
  module ClassMethods
    def attribute(name, value = nil)
      ns = namespace_scope.dup
      attribute_definitions[name] = AttributeDefinition.new(name, value, ns)
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

    def each_with_index(coll, &block)
      each_definitions[coll.hash] = EachDefinition.new(coll, block)
    end

    def each_definitions
      @each_definitions ||= {}
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
      perform_each_definitions
      perform_attribute_definitions(data)
    end
  end

  private

  def perform_each_definitions
    self.class.each_definitions.each do |_key, definition|
      values = definition.values
      block = definition.block
      context.instance_exec(&values).each_with_index(&block)
    end
  end

  def perform_attribute_definitions(data)
    self.class.attribute_definitions.each do |key, definition|
      val = definition.value
      d = definition.namespace.inject(data) { |h, k| h[k] ||= {} }
      k = key.respond_to?(:call) ? context.instance_exec(&key) : key
      d[k] = val.respond_to?(:call) ? context.instance_exec(&val) : val
    end
  end
end
