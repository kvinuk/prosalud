ready = ->
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '200px'
$(document).ready(ready)
$(document).on('turbolinks:load', ready)