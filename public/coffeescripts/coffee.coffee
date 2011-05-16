window.map = (msg) ->
    alert(msg)



window.gmap = (lat, long, zoom = 14) ->
    latlng = new google.maps.LatLng(lat, long);
    myOptions = zoom: zoom, center: latlng, mapTypeId: google.maps.MapTypeId.ROADMAP, overviewMapControl: false, overviewMapControlOptions: false, panControl: false, scaleControl: false, zoomControl: false, keyboardShortcuts: false, mapTypeControl: false, streetViewControl: false;
    map = new google.maps.Map(document.getElementById("map"),myOptions);
    marker = new google.maps.Marker({	position: new google.maps.LatLng(55.729999, 52.433219),	map: map });



$(document).ready ->





    $("input[type=text]").focus () ->
        $(this).select()


#
#    $('#click').raty (score, evt) ->
#        path: "/images/"
#        alert('ID: ' + this.attr('id') + '\nscore: ' + score + '\nevent: ' + evt);