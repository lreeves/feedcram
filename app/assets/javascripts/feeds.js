(function ($) {
  $(function () {
    $(document).ready(function() {
      // Select the first entry
      var first = $('.entry').first();

      if(first.length) {
        first.addClass('current');
      }

      // Set all timestamps to browser local time
      $.each($('span#timestamp'), function(i, element) {
        var rawDate = element.innerHTML.trim();
        var date = new Date(Date.parse(rawDate));
        element.innerHTML = date.toLocaleString();
      });
    });

    $(document).keypress(function(event) {
      var cur = $('.current');

      if(event.which == 106) {
        var next = cur.next('.entry');

        if(next.length) {
          $(document).scrollTop(next.offset().top);
          cur.removeClass('current');
          next.addClass('current');
        } else {
          $(".mark-button").click();
        }
      } else if (event.which == 107) {
        var prev = cur.prev('.entry');

        if(prev.length) {
          $(document).scrollTop(prev.offset().top);
          cur.removeClass('current');
          prev.addClass('current');
        }
      }
    });
  });
})(jQuery);
