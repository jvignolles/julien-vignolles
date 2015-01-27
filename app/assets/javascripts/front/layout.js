$(function() {
  $.ajaxPrefilter(function(options, originalOptions, xhr) {
    if (!options.crossDomain) {
      var token = jQuery("meta[name='csrf-token']").attr("content");
      xhr.setRequestHeader('X-CSRF-Token', token);
    }
  });

  function bindCustomLightboxes() {
    $.extend(true, $.magnificPopup.defaults, {
      tClose: 'Fermer (Esc)', // Alt text on close button
      tLoading: 'Chargement…', // Text that is displayed during loading. Can contain %curr% and %total% keys
      gallery: {
        tPrev: 'Photo précédente (Flèche gauche)', // Alt text on left arrow
        tNext: 'Photo suivante (Flèche droite)', // Alt text on right arrow
        tCounter: '%curr% sur %total%' // Markup for "1 of 7" counter
      },
      image: {
        tError: '<a href="%url%">La photo</a> ne peut pas être chargée.' // Error message when image could not be loaded
      },
      ajax: {
        tError: '<a href="%url%">Le contenu</a> ne peut pas être chargé.' // Error message when ajax request failed
      }
    });
    $('.parent-lightbox').magnificPopup({
      delegate: 'a.custom-lightbox',
      gallery: {
        enabled: true
      },
      image: {
        titleSrc: 'title'
      },
      mainClass: 'mfp-with-zoom',
      type: 'image',
        zoom: {
          enabled: true, // By default it's false, so don't forget to enable it
          duration: 300, // duration of the effect, in milliseconds
          easing: 'ease-in-out', // CSS transition easing function
          // The "opener" function should return the element from which popup will be zoomed in
          // and to which popup will be scaled down
          // By defailt it looks for an image tag:
          opener: function(openerElement) {
            // openerElement is the element on which popup was initialized, in this case its <a> tag
            // you don't need to add "opener" option if this code matches your needs, it's defailt one.
            return openerElement.is('img') ? openerElement : openerElement.find('img');
          }
        }
    });
  }

  function bindDescriptions() {
    $('#js-heading-description-btn').click(function(e) {
      e.preventDefault();
      $('#js-heading-description').removeClass('folded');
    });
  }

  function bindExternalLinks() {
    $('a[rel*="external"]').attr('target', '_blank');
  }

  function bindFixedMenu() {
    $('#all').stickyMenu();
  }

  function bindMaps() {
    function initMap(id) {
      var canvas = $('#' + id);
      var centerCoord = null;
      var mapOptions = {
        scrollwheel: false,
        zoom: 15
      };
      if (canvas.data('lat') && canvas.data('lng')) {
        centerCoord = new google.maps.LatLng(canvas.data('lat'), canvas.data('lng'));
        mapOptions['center'] = centerCoord;
      }
      var map = new google.maps.Map(document.getElementById(id), mapOptions);
      if (centerCoord) {
        var marker = new google.maps.Marker({
          position: centerCoord,
          map: map
        });
      }
    }
    $('.js-canvas-map').each(function(e) {
      var canvas = $(this);
      var id = canvas.attr('id');
      google.maps.event.addDomListener(window, 'load', initMap(id));
      google.maps.event.addDomListener(window, 'resize', _.debounce(function() { initMap(id) }, 250));
    });
  }

  function bindMenu() {
    $('.menu-toggle').click(function(e) {
      e.preventDefault();
      e.stopPropagation();
      $('body').toggleClass('menu-expanded');
    });
    $('#all').click(function(e) {
      var body = $('body');
      if (body.hasClass('menu-expanded')) {
        var m = $(e.target);
        var p = m.closest('.menu');
        if (!p.length) {
          e.preventDefault();
          body.removeClass('menu-expanded');
        } else if (m.closest('.collapser').length) {
          body.removeClass('menu-expanded');
        }
      }
    });
  }

  function bindScrollTos() {
    $('a.scroll-to').click(function(e) {
      e.preventDefault();
      var link = $(this);
      $('body').scrollTo($(link.attr('href')), 500, { offset: { top: 30 }});
    });
  }

  function bindSidebars() {
    $('.product-brief-inner').sticky({
      topSpacing: 136,
      getWidthFrom: '.product-brief',
      responsiveWidth: true
    });
  }

  $(document).ready(function() {
    //bindCustomLightboxes();
    bindDescriptions();
    bindExternalLinks();
    bindFixedMenu();
    //bindMaps();
    bindMenu();
    bindScrollTos();
    //bindSidebars();
  });
});

/*
function hideAddressBar() {
  if (!window.location.hash) {
    if (document.height < window.outerHeight) {
      document.body.style.height = (window.outerHeight + 50) + 'px';
    }
    setTimeout(function() { window.scrollTo(0, 1); }, 50);
  }
}

if (window.addEventListener) {
  window.addEventListener("load", function() {
    if (!window.pageYOffset) { hideAddressBar(); }
  });
  window.addEventListener("orientationchange", hideAddressBar);
}
*/

