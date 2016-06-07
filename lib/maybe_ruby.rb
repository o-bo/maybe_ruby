module MaybeRuby
  require "maybe_ruby/version"
  require "maybe_ruby/maybe"
  require "maybe_ruby/just"
  require "maybe_ruby/nothing"

end

def Maybe(value)
  MaybeRuby::Maybe.new(value)
end
