module Habuco
  class EachDefinition
    attr_reader :values, :block

    def initialize(values, block)
      @values = values
      @block = block
    end
  end
end
