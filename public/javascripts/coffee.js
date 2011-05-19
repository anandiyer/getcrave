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
      position: new google.maps.LatLng(lat, long),
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
  window.g_notice = function(type, text) {
    return $.gritter.add({
      title: type,
      text: text
    });
  };
  window.save_helpfull = function() {};
  window.save_menu_item = function(mid) {
    var path;
    path = $("#flag_icons div.save_icon[id=mid_" + mid + "]");
    $(path).removeClass("not_saved_item").addClass("saved_item");
    return g_notice("Notification", "Item saved!");
  };
  window.add_review = function(id_of_menu_item, msg) {
    update_reviews(id_of_menu_item);
    return $("#comment_wrapper").slideUp("slow", function() {
      var couner_reviews;
      $(this).empty();
      $("<h1>" + msg + "<h1>").appendTo("#comment_wrapper");
      couner_reviews = $("#text_column #rating span").text();
      $("#text_column #rating span").html(parseInt(couner_reviews) + 1);
      return $("#comment_wrapper").slideDown("normal");
    });
  };
  $(document).ready(function() {
    var lat, long;
    lat = $("#current_info_wrapper").data("latitude");
    long = $("#current_info_wrapper").data("longitude");
    $(".yes_answer").live("click", function(event) {
      var form, found_helpfull_number, increment, link, link_text;
      if ($(this).find("a").length > 0) {
        event.preventDefault();
        link = $(this).find("a");
        link_text = $(link).text();
        $(this).find("span").html(link_text);
        found_helpfull_number = $(this).next();
        increment = parseInt(found_helpfull_number.text().replace(/[(|)]/ig, ""), 10) + 1;
        $(found_helpfull_number).text("(" + increment + ")");
        form = $(this).find("form");
        return form.submit();
      }
    });
    $(".not_saved_item.save_icon").click(function() {
      $(this).find("form").submit();
      return $(this).unbind('click');
    });
    $("#select_box_hint").click(function() {
      return $("#sort_by").find("ul").slideToggle("slow");
    });
    $("#sort_by ul li").live("click", function() {
      $("#select_sorttype").val($(this).text());
      return $("#sort_by ul").slideUp();
    });
    $("#reviews_wrapper #show_more_button").live('click', function(e) {
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
    return $("input[type=text]").focus(function() {
      return $(this).select();
    });
  });
}).call(this);
