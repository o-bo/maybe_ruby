module MaybeRuby
  require "maybe_ruby/version"
  require "maybe_ruby/maybe"
  require "maybe_ruby/just"
  require "maybe_ruby/nothing"
  require "maybe_ruby/done"

end

def Maybe(value)
  MaybeRuby::Maybe.new(value)
end
