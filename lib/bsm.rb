# frozen_string_literal: false

require 'bsm/version'
require 'bsm/internal'

module Bsm
  # Raised when bsm2 rejects input. Carries the structured error fields
  # (line, column, length, line_text) from the native library so callers can
  # report precise locations.
  class InvalidInput < StandardError
    attr_accessor :line, :column, :length, :line_text
  end

  # The generator class. Input is in bsm2 literate format: a line is data
  # only if it starts with a semicolon (;); other lines are ignored.
  class Generator
    def initialize(_options = {})
      @generator = GeneratorInternal.new
    end

    def generate(input)
      @generator.generate_raw(input)
    end
  end
end
