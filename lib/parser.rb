class Parser

  AVALIBLE_CURRENCY = RemoteRates::PATHS.map(&:values).flatten.uniq

  def data
    raise NoMethodError.new("No method #data for parser \"#{self.class}\"")
  end

end