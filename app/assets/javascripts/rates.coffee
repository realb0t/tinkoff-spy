(() ->
  $(document).ready ->

    $('.refresh-btn').on 'click', (e) ->
      e.preventDefault()
      alert(0)

    $('.create-alert-btn').on 'click', (e) ->
      e.preventDefault()
      $("#alertWin").modal('show')
)()