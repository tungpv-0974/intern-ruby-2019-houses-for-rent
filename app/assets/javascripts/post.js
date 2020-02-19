$(document).on('ready turbolinks:load', function() {
  function checkForInput(element) {
    const $label = $(element).siblings('label');
    $label.toggleClass('active', $(element).val().length > 0);
  }

  $('input.form-control').each(function() {
    checkForInput(this);
  });

  $('textarea.form-control').each(function() {
    checkForInput(this);
  });
});
