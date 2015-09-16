class Stats

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
          bid: (daily_rates.map(&:ask).sum.to_d / daily_rates.count),
          ask: (daily_rates.map(&:bid).sum.to_d / daily_rates.count)
        }
      },
      spread: {
        absolute: current.absolute_spread,
        comparative: current.comparative_spread
      },
      forecast: forecast
    }
  end

  protected

  # Прогноз направления курса (bear или bull)
  # на основе цен открытия и закрытия текущего 
  # периода (день)
  #
  # Если за сегодняшний день нет ставок, то
  # считается что не закрыт вчерашний
  #
  # @return [Symbol]
  def forecast
    start = daily_rates.last || yesterday_rates
    close = current.ask.to_d + current.bid / 2
    open  = start.ask.to_d + start.bid / 2
    open > close ? :bear : :bull
  end

  # Последняя ставка по валюте
  # 
  # @return [Rate]
  def current
    @current ||= default.first
  end

  # Дневные ставки по валюте
  # 
  # @return [Array[Rate]]
  def daily_rates
    @daily_rates ||= default.where('parsed_at > ?', Time.now.beginning_of_day).to_a
  end

  # Дневные ставки по валюте
  # 
  # @return [Array[Rate]]
  def yesterday_rates
    @yesterday_rates ||= default.where('parsed_at > ?', Time.now.yesterday.beginning_of_day).to_a
  end

  def default
    Rate.order('parsed_at DESC').where(from: @currency)
  end

end