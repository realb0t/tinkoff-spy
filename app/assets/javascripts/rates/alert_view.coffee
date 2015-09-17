class window.AlertSaveView
  constructor: ->
    @$currencySelect = $('#currencySelect')
    @$dealTypeSelect = $('#dealTypeSelect')
    @$signSelect = $('#signSelect')
    @$valueInput = $('#valueInput')
    @$emailInput = $('#emailInput')
    @$form       = $("#alertWin")
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
    @$form.modal('show')
  save: ->
    return null if @saving
    @saving = true
    $.ajax({
      url: "/alerts.json",
      method: "POST",
      data: @data(),
      dataType: "json"
    })
    .done -> alert('Saved')
    .fail -> alert('Error')
    .always =>
      @$form.modal('hide')
      @saving = false