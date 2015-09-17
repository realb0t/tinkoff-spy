(() ->
  $(document).ready ->

    statView = new StatsView()
    alertSaveView = new AlertSaveView()

    $('.refresh-btn').on 'click', (e) ->
      e.preventDefault()
      statView.refresh()

    $('.create-alert-btn').on 'click', (e) ->
      e.preventDefault()
      alertSaveView.showForm()
      

    statView.refresh()
)()