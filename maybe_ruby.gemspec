# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'maybe_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "maybe_ruby"
  spec.version       = MaybeRuby::VERSION
  spec.authors       = ["o-bo"]

  spec.summary       = %q{An implementation of the Maybe monad in ruby.}
  spec.description   = %q{MaubeRuby is a simple implementation of the Maybe monad in ruby.}
  spec.homepage      = "https://github.com/o-bo/maybe_ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "terminal-notifier-guard"
end
