class Stats

  def self.represent
    { USD: new('USD').represent,
      EUR: new('EUR').represent }
  end

  def initialize(currency)
    @currency = currency
  end
    
  def represent
    {
      rate: {
        current: {
          bid: current.bid, ask: current.ask
        },
        daily: {
          bid: (daily_rates.map(&:ask).sum.to_d / daily_rates.count).to_f,
          ask: (daily_rates.map(&:bid).sum.to_d / daily_rates.count).to_f
        }
      },
      spread: {
        absolute: current.absolute_spread,
        comparative: (current.comparative_spread * 100).round(1)
      },
      forecast: forecast
    }
  end

  protected

  # Прогноз направления курса (bear или bull или indefinitely)
  # на основе цен открытия и закрытия текущего 
  # периода (день)
  #
  # Если за сегодняшний день нет ставок, то
  # считается что не закрыт вчерашний
  #
  # @return [Symbol]
  def forecast
    start = daily_rates.last || yesterday_rates.last || empty_rate
    close = current.ask.to_d + current.bid / 2
    open  = start.ask.to_d + start.bid / 2

    return :bear if open > close
    return :bull if open < close
    :indefinitely
  end

  # Пустая ставка (для случаев когда нет ставок)
  #
  # @return [Rate]
  def empty_rate
    Rate.new(bid: 0, ask: 0)
  end

  # Последняя ставка по валюте
  # 
  # @return [Rate]
  def current
    @current ||= default.first || empty_rate
  end

  # Дневные ставки по валюте
  # 
  # @return [Array[Rate]]
  def daily_rates
    @daily_rates ||= default.where('parsed_at >= ?', Time.now.beginning_of_day).to_a
  end

  # Дневные ставки по валюте
  # 
  # @return [Array[Rate]]
  def yesterday_rates
    @yesterday_rates ||= default.where('parsed_at < ?', Time.now.beginning_of_day).where('parsed_at >= ?', Time.now.yesterday.beginning_of_day).to_a
  end

  def default
    Rate.order('parsed_at DESC').where(from: @currency)
  end

end