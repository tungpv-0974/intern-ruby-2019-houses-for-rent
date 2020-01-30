$(document).on("ready turbolinks:load", function() {
  $(".active-testimonial-carusel").owlCarousel({
    items: 3,
    loop: true,
    margin: 30,
    dots: true,
    autoplayHoverPause: true,
    smartSpeed: 1500,
    autoplay: true,
    autoplay: true,
    responsive: {
      0: {
        items: 1
      },
      480: {
        items: 1,
      },
      768: {
        items: 2,
      },
      992: {
        items: 3,
      }
    }
  });

  $(".active-testimonial-carusel").owlCarousel({
    items: 3,
    loop: true,
    margin: 30,
    dots: true,
    autoplayHoverPause: true,
    smartSpeed: 650,
    autoplay: true,
    responsive: {
      0: {
        items: 1
      },
      480: {
        items: 1,
      },
      768: {
        items: 2,
      },
      992: {
        items: 3,
      }
    }
  });

  $("#range").ionRangeSlider({
    hide_min_max: true,
    keyboard: true,
    min: 200,
    max: 100000,
    from: 15000,
    to: 100000,
    type: "double",
    step: 1,
    prefix: "",
    grid: true
  });

  $("#range2").ionRangeSlider({
    hide_min_max: true,
    keyboard: true,
    min: 50,
    max: 1500,
    from: 250,
    to: 1500,
    type: "double",
    step: 1,
    prefix: "",
    grid: true
  });

  $('#profile-image1').on('click', function() {
    $('#profile-image-upload').trigger('click');
  });
});
