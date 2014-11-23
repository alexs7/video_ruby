# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'video_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "video_ruby"
  spec.version       = VideoRuby::VERSION
  spec.authors       = ["alrosh7"]
  spec.email         = ["alrosh7@gmail.com"]
  spec.summary       = %q{Ruby/CUDA Image and Video Processor}
  spec.description   = %q{Software using Ruby and CUDA to process images}
  spec.homepage      = "http://www.none.com"
  spec.license       = "MIT"

  spec.files         = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 0"
  spec.add_dependency "facter", "~> 2.2.0", ">= 2.2.0"
  spec.add_dependency "byebug", "~> 3.5.1", ">= 3.5.1"
  spec.add_dependency "json", "~> 1.8.1", ">= 1.8.1"
  spec.add_dependency "chunky_png", "~> 1.3.3", ">= 1.3.3"
end
