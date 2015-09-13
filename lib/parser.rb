class Parser

  def data
    raise NoMethodError.new("No method #data for parser \"#{self.class}\"")
  end

end