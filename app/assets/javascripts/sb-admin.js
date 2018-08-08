(function($) {
  // var sidebarActiveId = localStorage.getItem('sidebar-active-id');
  // console.log('The ID Stored IS')
  // console.log(sidebarActiveId)
  // console.log('The ID Stored IS')
  // if (sidebarActiveId) {
  //   $(sidebarActiveId).parent().addClass("active");
  // }

  "use strict"; // Start of use strict

  // Toggle the side navigation
  $("#sidebarToggle").click(function(e) {
    e.preventDefault();
    $("body").toggleClass("sidebar-toggled");
    $(".sidebar").toggleClass("toggled");
  });

  // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
  $('body.fixed-nav .sidebar').on('mousewheel DOMMouseScroll wheel', function(e) {
    if ($window.width() > 768) {
      var e0 = e.originalEvent,
        delta = e0.wheelDelta || -e0.detail;
      this.scrollTop += (delta < 0 ? 1 : -1) * 30;
      e.preventDefault();
    }
  });

  // Scroll to top button appear
  $(document).scroll(function() {
    var scrollDistance = $(this).scrollTop();
    if (scrollDistance > 100) {
      $('.scroll-to-top').fadeIn();
    } else {
      $('.scroll-to-top').fadeOut();
    }
  });

  // Smooth scrolling using jQuery easing
  $(document).on('click', 'a.scroll-to-top', function(event) {
    var $anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: ($($anchor.attr('href')).offset().top)
    }, 1000, 'easeInOutExpo');
    event.preventDefault();
  });

  // $('.sidebar a').mouseover(function() {
  //   $(".sidebar").find(".active").removeClass("active");
  //   console.log($(this)[0].id);
  //   localStorage.setItem('sidebar-active-id', $(this)[0].id );
  //   $(this).parent().addClass("active");
  // });



})(jQuery); // End of use strict
