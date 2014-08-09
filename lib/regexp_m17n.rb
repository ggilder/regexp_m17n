module RegexpM17N
  def self.non_empty?(str)
    # Optimal case that avoids conversions
    if str.encoding.ascii_compatible?
      str =~ /^.+$/
    else
      str.force_encoding(Encoding::BINARY) =~ Regexp.new('^.+$'.encode(Encoding::BINARY))
    end
  end
end
