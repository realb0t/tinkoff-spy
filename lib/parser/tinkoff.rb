require 'json'

class Parser
  class Tinkoff < self
    def data
      response = HTTParty.get('https://www.tinkoff.ru/api/v1/currency_rates/')
      data     = response.present? ? response.with_indifferent_access : {}
      
      if response.code == 200 && data[:resultCode] == "OK"
        dataTransforme(data)
      else
        raise Parser::Error.new(self), "Tinkoff API not avalible"
      end
    end

    protected

    def dataTransforme(data)
      rates = {}

      avalibleCardsTransfersRates = data[:payload][:rates].select do |rate|
        rate[:category] == "DepositPayments" &&
          Parser::AVALIBLE_CURRENCY.include?(rate[:toCurrency][:name].to_sym) &&
          Parser::AVALIBLE_CURRENCY.include?(rate[:fromCurrency][:name].to_sym)
      end

      avalibleCardsTransfersRates.each do |rate|
        from = rate[:fromCurrency][:name].to_sym
        to   = rate[:toCurrency][:name].to_sym
        ask  = rate[:sell]
        bid  = rate[:buy]

        rates[from] ||= {}
        rates[from][to] = { ask: ask, bid: bid }
      end

      rates
    end
  end
end