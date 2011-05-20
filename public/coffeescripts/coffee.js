(function() {
  var gmap;
  window.map = function(msg) {
    return alert(msg);
  };
  gmap = function() {
    var latlng, map, marker, myOptions;
    alert("gmap 21");
    latlng = new google.maps.LatLng(55.729999, 52.433219);
    myOptions = {
      zoom: 14,
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
    map = new google.maps.Map(document.getElementById("current_info_wrapper"), myOptions);
    return marker = new google.maps.Marker({
      position: new google.maps.LatLng(55.729999, 52.433219),
      map: map
    });
  };
  $(document).ready(function() {
    gmap();
    return $("input[type=text]").focus(function() {
      return $(this).select();
    });
  });
}).call(this);
