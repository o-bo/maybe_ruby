module MaybeRuby
  class Maybe

    def initialize(value)
      @value = value ?
        Just.new(value) :
        Nothing.new
    end


    # Tested
    def get
      @value.get
    end


    # Tested
    def or_else(else_value)
      Maybe(@value.or_else(else_value))
    end


    # Tested
    def then(f=nil)
      return Maybe(@value.get) unless f and f.is_a?(Proc) and @value.is_a?(Just)
      return Maybe(f.(@value.get))
    end


    # To be tested
    def apply(ff)
      f = ff && ff.is_a?(Maybe) && ff.get
      return Maybe(@value.get) unless f and f.is_a?(Proc) and @value.is_a?(Just)
      return Maybe(f.(@value.get))
    end
  end
end