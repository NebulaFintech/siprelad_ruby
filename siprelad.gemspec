lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'siprelad/version'

Gem::Specification.new do |spec|
  spec.name          = 'siprelad'
  spec.version       = Siprelad::VERSION
  spec.authors       = ['Mauricio Murga']
  spec.email         = ['murga.mauricio@gmail.com']

  spec.summary       = 'A small client for Siprelad web service.'
  spec.description   = 'A small client for Siprelad web service.'
  spec.homepage      = 'https://github.com/NebulaFintech'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency "bundler"
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'activesupport'
  spec.add_dependency 'savon'
end
