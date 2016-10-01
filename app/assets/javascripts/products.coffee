window.changeImage = (id)->
  src = $('#' + id).attr('src');
  $('#main_image').attr('src', src);