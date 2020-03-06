$(document).on('ready turbolinks:load', function() {
  $(".spinner").hide();

  $('.ajax-load').click(function(){
    $('.spinner').show();
  });
});
