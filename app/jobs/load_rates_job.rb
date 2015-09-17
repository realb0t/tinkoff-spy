class LoadRatesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    parser = ::Parser::Tinkoff.new
    fabric = ::RemoteRates.new(parser)
    rates  = fabric.factory
    Rate.transaction { rates.map(&:save!) }
  end
end
