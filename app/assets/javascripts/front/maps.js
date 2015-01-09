$(function() {
  function initCanvasMap() {
    var canvas = $('#js-canvas-map');
    if (!canvas.length) { return; }

    function initMap() {
      var centerCoord = null;
      var mapOptions = {
        scrollwheel: false,
        zoom: 15
      };
      if (canvas.data('lat') && canvas.data('lng')) {
        centerCoord = new google.maps.LatLng(canvas.data('lat'), canvas.data('lng'));
        mapOptions['center'] = centerCoord;
      }
      var map = new google.maps.Map(document.getElementById("js-canvas-map"), mapOptions);
      if (centerCoord) {
        var marker = new google.maps.Marker({
          position: centerCoord,
          map: map
        });
      }
    }
    google.maps.event.addDomListener(window, 'load', initMap);
    google.maps.event.addDomListener(window, 'resize', _.debounce(initMap, 300));
  }

  $(document).ready(function() {
    initCanvasMap();
  });
});

