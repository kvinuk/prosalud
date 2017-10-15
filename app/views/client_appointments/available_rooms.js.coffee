$("#consulting_rooms").empty()
  .append("<%= escape_javascript(render :partial => 'consulting_rooms', :locals => {:consulting_rooms => @consulting_rooms}) %>")
$("#therapists").empty()
  .append("<%= escape_javascript(render :partial => 'therapists', :locals => {:therapists => @therapists}) %>")