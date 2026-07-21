# frozen_string_literal: false

require 'bsm/version'
require 'bsm/internal'

module Bsm
  class InvalidInput < StandardError; end

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
