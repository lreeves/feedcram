(function ($) {
  $(function () {
    $(document).keypress(function(event) {
      if(event.which == 106) {
        var $cur = $('.current');
        var $next = $cur.next('.entry');

        if($next.length) {
          $(document).scrollTop($next.offset().top);
          $cur.removeClass('current');
          $next.addClass('current');
        } else {
          $(".mark-button").click();
        }
      } else if (event.which == 107) {
        var $cur = $('.current');
        var $prev = $cur.prev('.entry');

        if($prev.length) {
          $(document).scrollTop($prev.offset().top);
          $cur.removeClass('current');
          $prev.addClass('current');
        }
      }
    });
  })
})(jQuery);
