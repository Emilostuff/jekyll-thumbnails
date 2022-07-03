# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
    spec.name          = "jekyll-thumbnails"
    spec.version       = "0.1.0"
    spec.authors       = ["Emil Skydsgaard"]
    spec.summary       =  "A Jekyll plugin to replace images with a lower resolution thumbnail for optimized performance."
    spec.license       = "MIT"
    spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    spec.require_paths = ["lib"]
    spec.add_dependency 'jekyll'
    spec.add_dependency 'image_processing', '~> 1.0'
    spec.add_development_dependency "bundler", "~> 1.10"
  end
  
