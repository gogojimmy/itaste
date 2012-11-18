jQuery ->
  $(".date-picker").datepicker
    dateFormat: 'yy-mm-dd'

  $(".producer-picker").autocomplete
    source: $(".producer-picker").data('autocomplete-source')

  $("#serving_temperature_range").text ($("#serving_temperature_from").val | 15) + "度 - " + ($("#serving_temperature_to").val | 17) + "度"

  $("#serving-temperature-range-ui").slider
    range: true
    min: 5
    max: 25
    values: [$("#serving_temperature_from").val | 15, $("#serving_temperature_to").val | 17]
    slide: (event, ui) ->
      $("#serving_temperature_range").text ui.values[0] + "度 - " + ui.values[1] + "度"
      $("#serving_temperature_from").val ui.values[0]
      $("#serving_temperature_to").val ui.values[1]
