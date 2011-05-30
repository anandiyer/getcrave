(function() {
  var after_send, before_send, cl, disher_review_wrapper, error, geo;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  disher_review_wrapper = $("#reviews_wrapper");
  cl = function(msg) {
    return console.log(msg);
  };
  window.gmap = function(lat, long, zoom, coor_array) {
    var latlng, ll, map, myOptions, _i, _len, _results;
    if (zoom == null) {
      zoom = 10;
    }
    if (coor_array == null) {
      coor_array = [[lat, long]];
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
    _results = [];
    for (_i = 0, _len = coor_array.length; _i < _len; _i++) {
      ll = coor_array[_i];
      g_notice("Lang Lat", ll[0] + "<br />" + ll[1]);
      _results.push(new google.maps.Marker({
        position: new google.maps.LatLng(ll[0], ll[1]),
        map: map
      }));
    }
    return _results;
  };
  before_send = function(obj) {
    return obj.fadeTo("slow", .5);
  };
  after_send = function(obj, html) {
    obj.fadeTo("fast", 1);
    return obj.html(html);
  };
  window.menu_item_photos_uploaded = function() {
    return alert(1);
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
  window.set_gmap = function(zoom) {
    var ar, lat, long, obj;
    if (zoom == null) {
      zoom = 10;
    }
    cl("set_gmap");
    ar = [];
    if ($(".menu_items_location").length > 0 || $(".restaurants_index").length > 0 || $(".user_saved_menu_items_index").length > 0) {
      cl("if $(.menu_items_location).length > 0 || $(.restaurants_index) .length > 0");
      $(".restaurant_menu_item_wrapper").each(function() {
        var lat, long;
        lat = $(this).data("latitude");
        long = $(this).data("longitude");
        return ar.push([lat, long]);
      });
      lat = ar[0][0];
      long = ar[0][1];
      return gmap(lat, long, zoom, ar);
    } else if ($("#current_info_wrapper").length > 0) {
      cl("else if $(#current_info_wrapper).length >0");
      obj = $("#current_info_wrapper");
      cl(lat = obj.data("latitude"));
      cl(long = obj.data("longitude"));
      return gmap(lat, long, zoom);
    } else {
      return cl("else");
    }
  };
  window.gallery_init = function() {
    return $('#gallery a').lightBox({
      overlayBgColor: '#FFF',
      overlayOpacity: 0.6,
      imageLoading: '/images/lightbox-ico-loading.gif',
      imageBtnClose: '/images/lightbox-btn-close.gif',
      imageBtnPrev: '/images/lightbox-btn-prev.gif',
      imageBtnNext: '/images/lightbox-btn-next.gif',
      containerResizeSpeed: 100,
      txtImage: 'Imagem',
      txtOf: 'of'
    });
  };
  error = function(msg) {
    return $.gritter.add({
      title: "GEO Error",
      text: msg,
      image: "/images/error_icon.png",
      sticky: __bind(function() {
        return true;
      }, this)
    });
  };
  geo = function(position) {
    var lat, long;
    lat = position.coords.latitude;
    return long = position.coords.longitude;
  };
  $(document).ready(function() {
    $(".label_div ul li").live("click", function(event) {
      var id;
      id = $(this).attr("id");
      return $("#labels form").find("input#menu_label_association_menu_label_id").val(id).end().submit();
    });
    $("#desc_wrap #labels a").live("click", function(event) {
      var offset;
      offset = $(this).offset();
      $(".label_div_wrapper").offset({
        top: offset.top + 12,
        left: offset.left - 84
      }).slideDown();
      return event.preventDefault();
    });
    if ($("#gallery").length > 0) {
      gallery_init;
    }
    $(document).ajaxError(function() {
      return $.gritter.add({
        title: "Error",
        text: "Ajax error!",
        image: "/images/error_icon.png",
        sticky: __bind(function() {
          return true;
        }, this)
      });
    });
    if (window.location.port !== "3005") {
      set_gmap(2);
    }
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
      var id_of_menu_item, lat, long, new_limits, obj, path;
      id_of_menu_item = $(this).data("itemid");
      new_limits = $(this).data("next");
      if ($(".menu_items_location").length > 0 || $(".restaurants_index").length > 0) {
        lat = $("body").data("latitude");
        long = $("body").data("longitude");
        obj = $("#update_place_restaurants");
        if ($(".menu_items_location").length > 0) {
          path = "/menu_items/show_menu_items_nearby?lat=" + lat + "&long=" + long + "&limit=" + new_limits;
        } else {
          path = "/restaurants/show_restaurants_nearby?lat=" + lat + "&long=" + long + "&limit=" + new_limits;
        }
      } else if ($(".menu_items_location").length > 0) {
        obj = $("#reviews_wrapper #update_place");
        path = "/menu_items/" + id_of_menu_item + "/show_reviews?limit=" + new_limits;
      } else if ($(".user_saved_menu_items_index").length > 0) {
        obj = $("#update_place_restaurants");
        path = "/user_saved_menu_items/show_menu_items_saved?limit=" + new_limits;
      }
      return $.ajax({
        url: path,
        before_send: function() {
          return before_fade(obj);
        },
        success: function(html) {
          after_send(obj, html);
          $("#show_more_button").attr("data-next", new_limits * 2);
          return set_gmap(8);
        }
      });
    });
    return $("input[type=text]").focus(function() {
      return $(this).select();
    });
  });
}).call(this);
