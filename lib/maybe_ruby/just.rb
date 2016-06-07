module MaybeRuby
  class Just

    def initialize(value)
      @value = value
    end

    def get
      @value
    end


    def or_else(else_value)
      @value
    end
  end
end
