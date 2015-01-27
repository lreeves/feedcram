(function ($) {
  $(function () {

    $("*").keypress(function(event) {
      if(event.which == 106) {
        // alert('j');
        var $next = $('current').next('.entry');
        // alert($next);
        var top = $next.offset().top;

        $('body').animate({
          scrollTop: top
        }, function () {
          $next.addClass('current');
        });
      } else if (event.which == 107) {
        alert('k');
      }
    });
  })

})(jQuery);
