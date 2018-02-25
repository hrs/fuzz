lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fuzz/version"

Gem::Specification.new do |spec|
  spec.name = "fuzz"
  spec.version = Fuzz::VERSION
  spec.authors = ["Harry Schwartz"]
  spec.email = ["hello@harryrschwartz.com"]
  spec.summary = "Wrap command-line tools to graphically select from a list of Ruby objects!"
  spec.homepage = "https://github.com/hrs/fuzz"
  spec.license = "GPL-3.0"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
