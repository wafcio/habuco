module Habuco
  class AttributeDefinition
    attr_reader :name, :value, :namespace

    def initialize(name, value, namespace)
      @name = name
      @value = value
      @namespace = namespace
    end
  end
end
