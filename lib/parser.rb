class Parser

  AVALIBLE_CURRENCY = [ :EUR, :RUB, :USD ]

  def data
    raise NoMethodError.new("No method #data for parser \"#{self.class}\"")
  end

end