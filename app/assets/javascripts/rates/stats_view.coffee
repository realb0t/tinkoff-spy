class window.StatsView
  constructor: ->
    @usdView = new CurrencyView('USD', {})
    @eurView = new CurrencyView('EUR', {})
  loadCurrentStats: (callback) ->
    $.get '/current.json', (@stats) => callback()
  render: ->
    @usdView.applyStats(@stats.USD).render()
    @eurView.applyStats(@stats.EUR).render()
  refresh: ->
    @loadCurrentStats => @render()

class window.CurrencyView
  constructor: (@currency, @stats) ->
    statsCl  = ".#{@currency.toLowerCase()}-stats"
    @$block  = $(statsCl)

    @$spreadAbsolute    = @$block.find('.spread-absolute')
    @$spreadComparative = @$block.find('.spread-comparative')
    @$rateCurrentBid    = @$block.find('.rate-current.rate-current_bid')
    @$rateCurrentAsk    = @$block.find('.rate-current.rate-current_ask')
    @$rateDailyBid      = @$block.find('.rate-daily.rate-daily_bid')
    @$rateDailyAsk      = @$block.find('.rate-daily.rate-daily_ask')
    @$forecast          = @$block.find('.forecast')
  applyStats: (@stats) -> @
  render: ->
    if (@stats != {})
      @$spreadAbsolute.text(+@stats.spread.absolute)
      @$spreadComparative.text(+@stats.spread.comparative)
      @$rateCurrentBid.text(+@stats.rate.current.bid)
      @$rateCurrentAsk.text(+@stats.rate.current.ask)
      @$rateDailyBid.text(+@stats.rate.current.bid)
      @$rateDailyAsk.text(+@stats.rate.current.ask)

    @$forecast.removeClass('forecast.icon-arrow-down')
    @$forecast.removeClass('forecast.icon-arrow-up')
    @$forecast.removeClass('forecast.icon-refresh')
    @$block.removeClass('bull')
    @$block.removeClass('bear')

    if (@stats.forecast == 'bear')
      @$forecast.addClass('forecast.icon-arrow-up')
      @$block.addClass('bear')
    else if (@stats.forecast == 'bull')
      @$forecast.addClass('forecast.icon-arrow-down')
      @$block.addClass('bull')
    else
      @$forecast.addClass('forecast.icon-refresh')