class Robot

  # @param [Parser] Драйвер для парсинга
  def initialize(parser)
    @parser = parser
  end

  # Возвращает данные о текущих курсах валют
  #
  # @param [Boolean] Если нужно обновление при парсинге
  # @return [Hash] Кеш с катеровками
  def data(reload = false)
    if reload
      parse
    else
      @data.nil? ? parse : @data
    end
  end

  protected

  # Парсит данные курсов валют
  #
  # @return [Hash] Кеш с катеровками
  def parse
    @data = @parser.data
  end

end