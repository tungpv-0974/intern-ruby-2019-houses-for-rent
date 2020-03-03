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

  $('#show_more').click(function(){
    var dots = $('#dots');
    var moreText = $('#more');
    var btnText = $('#show_more');

    if (dots.css('display') === 'none') {
      dots.css('display', 'inline');
      btnText.html(I18n.t('posts.show.show_more'));
      moreText.css('display', 'none');
    } else {
      dots.css('display', 'none');
      btnText.html(I18n.t('posts.show.show_less'));
      moreText.css('display', 'inline');
    }
  });
});
