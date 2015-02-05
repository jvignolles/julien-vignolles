(function($) {
  $.fn.stickyMenu = function(options) {
    var config = $.extend({
      breakpoint: 300
    }, options);
    var fixMenu = function() {
      var menuSelector = $(this);
      //var viewportHeight = $(window).height();
      //var viewportWidth = $(window).width();
      //var documentHeight = $(document).height();
      var scroll_top = $(window).scrollTop();
      // calculate
      if (config.breakpoint < scroll_top) {
        menuSelector.addClass('sticky-menu');
      } else {
        menuSelector.removeClass('sticky-menu');
      }
    };
    return this.each(function() {
      $(window).on('scroll', _.debounce($.proxy(fixMenu, this), 250));
      $(window).on('resize', _.debounce($.proxy(fixMenu, this), 250));
      $.proxy(fixMenu, this)();
    });
  };
}(jQuery));
