# encoding: utf-8
require 'minitest/autorun'
require_relative '../lib/regexp_m17n'

class RegexpTest < MiniTest::Unit::TestCase
  def test_non_empty_string
    Encoding.list.each do |enc|
      str = encode_or_force('.', enc)

      # Force encoding for empty strings because:
      # 1. They're empty anyway
      # 2. JRuby appears to have a bug(?) where ''.encode(Encoding::UTF_16) => "\uFEFF" (BOM)
      empty = ''.force_encoding(enc)
      assert(RegexpM17N.non_empty?(str), "Failed on non-empty #{enc} string")

      # Test empty strings too!
      refute(RegexpM17N.non_empty?(empty), "Failed on empty #{enc} string")
    end
  end

  # Attempt to encode, but force encoding when no conversion is possible
  def encode_or_force(str, enc)
    begin
      str.encode(enc)
    rescue Encoding::ConverterNotFoundError
      str.force_encoding(enc)
    end
  end
end
