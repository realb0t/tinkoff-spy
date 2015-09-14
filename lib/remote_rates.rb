class RemoteRates

  PATHS = [ { from: :USD, to: :RUB }, { from: :EUR, to: :RUB } ]

  # @param [Parser] Драйвер для парсинга
  def initialize(parser)
    @parser = parser
  end

  # Возвращает данные о текущих курсах валют
  #
  # @param [Boolean] Если нужно обновление при парсинге
  # @return [Array[Rate]] Массив объектов Rate
  def factory(reload = true)
    if reload
      parse
    else
      @rates.nil? ? parse : @rates
    end
  rescue Parser::Error => e
    return []
  end

  protected

  # Парсит данные курсов валют
  #
  # @return [Array[Rate]] Массив объектов Rate
  def parse
    parsed_at      = Time.now
    data           = @parser.data
    avalible_paths = PATHS.select { |o| 
      data[o[:from]].present? && data[o[:from]][o[:to]].present? }
    
    @rates = avalible_paths.map do |o|
      Rate.new({
        parsed_at: parsed_at
      }.merge(o).merge(data[o[:from]][o[:to]]))
    end
  end
end
