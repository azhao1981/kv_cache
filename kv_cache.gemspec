# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kv_cache/version'

Gem::Specification.new do |spec|
  spec.name          = "kv_cache"
  spec.version       = KvCache::VERSION
  spec.authors       = ["azhao1981"]
  spec.email         = ["azhao.1981@gmail.com"]
  spec.description   = %q{Since using kv_cache, Mami need't to warry my db crashing anymore. :)}
  spec.summary       = %q{cache your data that you don't need to fetch from db.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "dalli"
end
