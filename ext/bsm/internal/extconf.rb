# frozen_string_literal: true

require 'mkmf'

# bsm2 source is vendored at GEM_ROOT/bsm2 (a git submodule).
# extconf lives at GEM_ROOT/ext/bsm/internal, so three dirs up to the gem root.
BSM2_DIR = File.expand_path('../../../bsm2', __dir__)

unless File.directory?(File.join(BSM2_DIR, 'src'))
  abort "bsm2 source not found at #{BSM2_DIR}/src. " \
        'If this is a checkout, init the submodule: git submodule update --init'
end

# Build the static library from vendored source.
Dir.chdir(BSM2_DIR) do
  success = system('make', 'libbsm2')
  abort 'Failed to build bsm2/libbsm2.a (requires g++ with C++17)' unless success
end

# Expose the C API header and the built static lib to the extension.
# rubocop:disable Style/GlobalVars
$INCFLAGS << " -I#{File.join(BSM2_DIR, 'src')}"
$LDFLAGS  << " -L#{File.join(BSM2_DIR, 'lib')}"
# rubocop:enable Style/GlobalVars

# libbsm2.a is C++ internally (std::string, new/delete); link the C++ runtime.
have_library('stdc++') or abort 'libstdc++ not found'
have_library('bsm2', 'bsm2_new') or abort 'libbsm2 not found / bsm2_new missing'

create_makefile('bsm/internal')
