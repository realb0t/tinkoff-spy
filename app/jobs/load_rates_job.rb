class LoadRatesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    fabric = RemoteRates.new(Parser::Tinkoff.new)
    rates  = fabric.factory
    Rate.transaction { rates.map(&:save!) }
  end
end
