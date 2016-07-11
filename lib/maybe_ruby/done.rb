module MaybeRuby
  class Done

    def initialize(value)
      @value = value
    end


    def get
      @value
    end


    def then
      @value
    end


    def or_else(else_value)
      @value
    end
  end
end
