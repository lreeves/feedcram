(function ($) {
  $(function () {
    $(document).keypress(function(event) {
      if(event.which == 106) {
        var $cur = $('.current');
        var $next = $cur.next('.entry');

        $('body').animate({
          scrollTop: $next.offset().top
        });

        $cur.removeClass('current');
        $next.addClass('current');
      } else if (event.which == 107) {
        var $cur = $('.current');
        var $prev = $cur.prev('.entry');

        $('body').animate({
          scrollTop: $prev.offset().top
        });

        $cur.removeClass('current');
        $prev.addClass('current');
      }
    });
  })
})(jQuery);
