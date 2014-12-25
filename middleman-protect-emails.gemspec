# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman-protect-emails/version'

Gem::Specification.new do |spec|
  spec.name          = 'middleman-protect-emails'
  spec.version       = Middleman::ProtectEmails::VERSION
  spec.authors       = ['Ankit Sardesai']
  spec.email         = ['amsardesai@gmail.com']
  spec.summary       = %q{Middleman extension for email link protection and obfuscation}
  spec.description   = %q{Middleman extension for email link protection and obfuscation.}
  spec.homepage      = ''
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency 'middleman-core', '~> 3.2'

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
end
