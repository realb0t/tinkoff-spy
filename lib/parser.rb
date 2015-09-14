class Parser

  AVALIBLE_CURRENCY = RemoteRates::PATHS.map(&:values).flatten.uniq

  # Возвращает вложенный хеш вставок с допустимыми 
  # валютами из AVALIBLE_CURRENCY
  # 
  # @return [Hash] Вложенный хеш ставок
  def data
    raise NoMethodError.new("No method #data for parser \"#{self.class}\"")
  end

end