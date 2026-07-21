# frozen_string_literal: true

require_relative 'lib/bsm/version'

Gem::Specification.new do |spec|
  spec.name          = 'bsm'
  spec.version       = Bsm::VERSION
  spec.authors       = ['David Siaw']
  spec.email         = ['874280+davidsiaw@users.noreply.github.com']

  spec.summary       = 'Write binary files in a human-readable way'
  spec.description   = 'Bsm converts literate text (semicolon-prefixed lines of hex, ' \
                       'strings, bitfields) into binary. Backed by the native bsm2 library.'
  spec.homepage      = 'https://github.com/davidsiaw/bsm'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/davidsiaw/bsm'
  spec.metadata['changelog_uri'] = 'https://github.com/davidsiaw/bsm'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # bsm2 is vendored as a git submodule and built from source at install time
  # by ext/bsm/internal/extconf.rb. Ship the source + build files so the gem
  # is self-contained. Exclude ext build artifacts (mkmf output) from the gem.
  spec.files = (Dir['{exe,lib,ext}/**/*'] +
               Dir['bsm2/src/**/*'] +
               %w[Gemfile bsm.gemspec bsm2/Makefile]).reject do |f|
    f =~ %r{^ext/.*\.(o|so|bundle)$} ||
      f =~ %r{^ext/.*/(Makefile|mkmf\.log)$}
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.extensions    = %w[ext/bsm/internal/extconf.rb]
end
