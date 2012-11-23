jQuery ->
  $(".date-picker").datepicker
    dateFormat: 'yy-mm-dd'

  $(".producer-picker, .wine-name-picker, .region-picker, .place-picker").autocomplete
    source: $(this).data('autocomplete-source')

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

  $("#food-token-input").tokenInput '/foods.json'
    theme: 'facebook'
    hintText: "輸入您搭配的食物種類，以半型逗號 ',' 隔開可輸入更多搭配的食物"
    searchingText: "搜尋中..."
    prePopulate: $('#food-token-input').data('load')

  $("#grape-token-input").tokenInput '/grapes.json'
    theme: 'facebook'
    hintText: "輸入這支酒的葡萄種類，以半型逗號 ',' 隔開可輸入更多葡萄品種"
    searchingText: "搜尋中..."
    prePopulate: $('#grape-token-input').data('load')

  $(".nav-tabs li:first").addClass 'active'
  $(".tab-content .tab-pane:first").addClass 'active'

  $("#new_photo").fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('#new_photo').append(data.context)
        data.submit()
      else
        alert("#{file.name} 並不是 gif, jpeg, 或 png 等支援的圖片格式")

    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')

    done: (e, data) ->
      data.context.remove() if data.context # remove progress bar

    fail: (e, data) ->
      alert("#{data.files[0].name} 上傳失敗.")
      data.context.remove() if data.context # remove progress bar
      console.log("Upload failed:")
      console.log(data.result)

    $(".rating > span").click ->
      $(this).nextAll().andSelf().each ->
        $(this).addClass 'stared'

    $("span.stared").click ->
      $(this).nextAll().andSelf().each ->
        $(this).removeClass 'stared'
