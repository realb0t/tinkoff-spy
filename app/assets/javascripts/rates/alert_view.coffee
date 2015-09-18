class window.AlertSaveView
  constructor: ->
    @$currencySelect = $('#currencySelect')
    @$dealTypeSelect = $('#dealTypeSelect')
    @$signSelect = $('#signSelect')
    @$valueInput = $('#valueInput')
    @$emailInput = $('#emailInput')
    @$formWin    = $("#alertWin")
    @$successWin = $("#successSaveWin")
    @$failureWin = $("#failureSaveWin")
    @$saveAlert  = $("#saveAlertBtn")
    @saving = false

    @$saveAlert.on 'click', (e) =>
      e.preventDefault()
      @save()
  data: ->
    { alert: {
      currency: @$currencySelect.val(),
      sign: @$signSelect.val(),
      value: @$valueInput.val(),
      deal_type: @$dealTypeSelect.val(),
      email: @$emailInput.val()
    } }
  showForm: ->
    @$formWin.modal('show')
  save: ->
    return null if @saving
    @$formWin.modal('hide')
    @saving = true
    $.ajax({
      url: "/alerts.json",
      method: "POST",
      data: @data(),
      dataType: "json"
    })
    .done => @$successWin.modal('show')
    .fail => @$failureWin.modal('show')
    .always =>
      @saving = false