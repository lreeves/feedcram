(function ($) {
  $(function () {
    $(document).ready(function() {
      // Select the first entry
      var $first = $('.entry').first();

      if($first.length) {
        $first.addClass('current');
      }

      // Set all timestamps to browser local time
      $.each($('span#timestamp'), function(i, element) {
        rawDate = element.innerHTML.trim();
        d = new Date(Date.parse(rawDate));
        element.innerHTML = d.toLocaleString();
      });
    });

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
