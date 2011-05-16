(function() {
  var after_send, before_send, disher_review_wrapper;
  disher_review_wrapper = $("#reviews_wrapper");
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
  before_send = function(obj) {
    return obj.fadeTo("slow", .5);
  };
  after_send = function(obj, html) {
    obj.fadeTo("slow", 1);
    return obj.html(html);
  };
  window.update_reviews = function(id_of_menu_item, limits) {
    var obj;
    if (limits == null) {
      limits = $("#show_more_button").data("step");
    }
    obj = $("#reviews_wrapper #update_place");
    return $.ajax({
      url: "/menu_items/" + id_of_menu_item + "/show_reviews?limit=" + limits,
      beforeSend: function() {
        return before_send(obj);
      },
      success: function(html) {
        return after_send(obj, html);
      }
    });
  };
  window.add_review = function(id_of_menu_item) {
    update_reviews(id_of_menu_item);
    return $.gritter.add({
      title: "Notification",
      text: "Review was succssecfully added!"
    });
  };
  $(document).ready(function() {
    return $("#reviews_wrapper #show_more_button").live('click', function(e) {
      var id_of_menu_item, new_limits, obj;
      obj = $("#reviews_wrapper #update_place");
      id_of_menu_item = $(this).data("itemid");
      new_limits = $(this).data("next");
      return $.ajax({
        url: "/menu_items/" + id_of_menu_item + "/show_reviews?limit=" + new_limits,
        before_send: function() {
          return before_fade(obj);
        },
        success: function(html) {
          after_send(obj, html);
          return $("#show_more_button").attr("data-next", new_limits * 2);
        }
      });
    });
  });
  $("input[type=text]").focus(function() {
    return $(this).select();
  });
}).call(this);
