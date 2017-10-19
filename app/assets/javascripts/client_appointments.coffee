$ ->
  $(document).on 'change', '#fecha', (evt) ->
    $.ajax '/client_appointments/available_rooms',
      type: 'GET'
      dataType: 'script'
      data: {
        year: $("#client_appointment_date_1i option:selected").val(),
        month: $("#client_appointment_date_2i option:selected").val()
        day: $("#client_appointment_date_3i option:selected").val()
        hour: $("#client_appointment_date_4i option:selected").val()
        minutes: $("#client_appointment_date_5i option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Available rooms select OK!")
