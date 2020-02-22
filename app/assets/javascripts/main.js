$(document).on('ready turbolinks:load', function() {
  $('.active-testimonial-carusel').owlCarousel({
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

  $('.active-testimonial-carusel').owlCarousel({
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

  $('#range').ionRangeSlider({
    hide_min_max: true,
    keyboard: true,
    min: 500000,
    max: 10000000,
    from: 1,
    to: 10000000,
    type: 'double',
    step: 1,
    prefix: '',
    grid: true
  });

  $('#range2').ionRangeSlider({
    hide_min_max: true,
    keyboard: true,
    min: 10,
    max: 100,
    from: 15,
    to: 80,
    type: 'double',
    step: 1,
    prefix: '',
    grid: true
  });

  $('#profile-image1').on('click', function() {
    $('#profile-image-upload').trigger('click');
  });

  $('#carousel').flexslider({
    animation: 'slide',
    controlNav: false,
    animationLoop: false,
    slideshow: false,
    itemWidth: 210,
    itemMargin: 5,
    asNavFor: '#slider'
  });

  $('#slider').flexslider({
    animation: 'slide',
    controlNav: false,
    animationLoop: false,
    slideshow: false,
    sync: '#carousel'
  });

  $('#search-icon').click(function() {
    $('#search-box').fadeToggle('5000');
  });

  $(document).on('change', '#select-province', function(){
    province_id = $(this).val();
    $.ajax({
      url: '/districts',
      data: {
        province_id: province_id
      }
    })

    $('#user_ward_id').html($('<option>', {
      text: I18n.t('address.select_ward')
    }));
  });

  $(document).on('change', '#select-district', function(){
    district_id = $(this).val();
    $.ajax({
      url: '/wards',
      data: {
        district_id: district_id
      }
    })
  });

  $('#open_notification').click(function(){
    $('#notificationContainer').fadeToggle(300);
    $('#notification_count').fadeOut('fast');
    return false;
  });

  $(document).click(function(){
    $('#notificationContainer').hide();
  });
});
