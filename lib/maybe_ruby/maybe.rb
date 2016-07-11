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
      Maybe(@value.or_else(else_value)) unless @value.is_a?(Done)
    end


    # Tested
    def then(f=nil)
      return if @value.is_a?(Done)
      return Maybe(@value.get) unless f and f.is_a?(Proc) and @value.is_a?(Just)
      return Maybe(f.(@value.get))
    end


    # Tested
    def apply(ff=nil)
      return if @value.is_a?(Done)
      return Maybe(nil) if @value.is_a?(Nothing)

      f = ff && ff.is_a?(Maybe) && ff.get
      return Maybe(f) unless f and f.is_a?(Proc)
      return Maybe(f.(@value.get))
    end
  end
end
