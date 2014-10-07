# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'baidumap/version'

Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '2.2.2'
  s.required_ruby_version = '>= 1.9.3'

  s.name              = 'baidumap'
  s.version           = Baidumap::VERSION
  s.license           = 'MIT'

  s.summary     = "A ruby wrapper of baidu map API"
  s.description = "Baidumap is a ruby CLI tool for baidu map service API."

  s.authors  = ["Xinghua Li"]
  s.email    = 'lixinghua2010@gmail.com'
  s.homepage = 'https://github.com/Lee2011/baidumap'

  all_files       = `git ls-files -z`.split("\x0")
  s.files         = all_files.grep(%r{^(bin|lib)/})
  s.executables   = all_files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE]

  s.add_runtime_dependency('mercenary', "~> 0.3.3")

  s.add_development_dependency('rake', "~> 10.1")
  s.add_development_dependency('rdoc', "~> 3.11")
end
