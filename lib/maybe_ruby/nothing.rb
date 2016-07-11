module MaybeRuby
  class Nothing

    def initialize
    end


    def get
      nil
    end


    def or_else(else_value)
      if else_value.respond_to?(:call)
        return else_value.call
      else
        return else_value
      end
    end
  end
end
