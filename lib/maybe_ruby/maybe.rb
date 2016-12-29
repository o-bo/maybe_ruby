module MaybeRuby
  class Maybe

    def initialize(value)
      @value = value ?
        Just.new(value) :
        Nothing.new
      # Overwrite by default value if it is a Done
      @value = Done.new(value.get) if value.is_a?(Done)
    end


    # Tested
    def get
      @value.get
    end


    # Tested
    def or_else(else_value)
      return Maybe(@value.or_else(else_value)) if @value.is_a?(Just)
      return Maybe(Done.new(@value.or_else(else_value)))
    end
    alias_method :else, :or_else


    # Tested
    def then(f=nil)
      return Maybe(Done.new(@value.get)) if @value.is_a?(Done)
      return Maybe(@value.get) unless f and f.is_a?(Proc) and @value.is_a?(Just)
      return Maybe(f.(@value.get))
    end
    alias_method :or, :then
    alias_method :map, :then


    # Tested
    def bind(f=nil)
      return Maybe(Done.new(@value.get)) if @value.is_a?(Done)
      return Maybe(@value.get) unless f and f.is_a?(Proc) and @value.is_a?(Just)

      result = f.(@value.get)
      return Maybe(result.get) if result.is_a?(Just) || result.is_a?(None) || result.is_a?(Done)
      return Maybe(result)
    end
    alias_method :flat_map, :bind
    alias_method :fmap, :bind


    # Tested
    def apply(ff=nil)
      return Maybe(nil) if @value.is_a?(Nothing)

      f = ff && ff.is_a?(Maybe) && ff.get
      return Maybe(f) unless f and f.is_a?(Proc)
      return Maybe(f.(@value.get))
    end
  end
end
