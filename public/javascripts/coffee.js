(function() {
  window.map = function(msg) {
    return alert(msg);
  };
  window.gmap = function(lat, long, zoom) {
    var latlng, map, marker, myOptions;
    if (zoom == null) {
      zoom = 14;
    }
    latlng = new google.maps.LatLng(lat, long);
    myOptions = {
      zoom: zoom,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      overviewMapControl: false,
      overviewMapControlOptions: false,
      panControl: false,
      scaleControl: false,
      zoomControl: false,
      keyboardShortcuts: false,
      mapTypeControl: false,
      streetViewControl: false
    };
    map = new google.maps.Map(document.getElementById("map"), myOptions);
    return marker = new google.maps.Marker({
      position: new google.maps.LatLng(55.729999, 52.433219),
      map: map
    });
  };
  $(document).ready(function() {
    return $("input[type=text]").focus(function() {
      return $(this).select();
    });
  });
}).call(this);
