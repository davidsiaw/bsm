# frozen_string_literal: false

require 'bsm/version'

module Bsm
  class InvalidInput < StandardError; end

  TWO_OCTET_REGEX = /^[0-9a-f]{2}$/i.freeze

  # The generator class
  class Generator
    def initialize(options = {})
      @options = options
    end

    def generate(input)
      tokens = input.split(/\s+/)
      result = ''

      tokens.each do |chr|
        next if chr.length.zero?
        raise InvalidInput, chr if chr !~ TWO_OCTET_REGEX

        result << chr.to_i(16)
      end
      result
    end
  end
end
