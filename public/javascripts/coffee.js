(function() {
  var after_send, before_send, cl, close_modal, disher_review_wrapper, error, geo;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  disher_review_wrapper = $("#reviews_wrapper");
  cl = function(msg) {
    return console.log(msg);
  };
  close_modal = function() {
    $('#mask').hide();
    return $('.modal_window').hide();
  };
  window.show_dialog = function(title, content) {
    modal_window();
    show_modal("modal_window");
    $(".modal_window .modal_title h1").empty().text(title);
    if (content) {
      return $(".modal_window .clone_me").empty().html(content);
    }
  };
  window.show_modal = function(modal_id) {
    cl(modal_id);
    $('#mask').css({
      'display': 'block',
      opacity: 0
    });
    $('#mask').fadeTo("fast", 0.6);
    return $('#' + modal_id).fadeIn("fast");
  };
  window.modal_window = function() {
    var window_height, window_width;
    cl(111);
    window_width = $(window).width();
    window_height = $(window).height();
    $('.modal_window').each(function() {
      var left, modal_height, modal_width, top;
      modal_height = $(this).outerHeight();
      modal_width = $(this).outerWidth();
      top = (window_height - modal_height) / 2;
      left = (window_width - modal_width) / 2;
      return $(this).css({
        'top': top,
        'left': left
      });
    });
    return $('.activate_modal').click(function() {
      var modal_id;
      modal_id = $(this).attr('name');
      return show_modal(modal_id);
    });
  };
  $('.close_modal').live("click", function() {
    return close_modal();
  });
  window.added_label = function(menu_item_id) {
    $.gritter.add({
      title: 'Notification',
      text: menu_item_id + ' Label was added!',
      image: '/images/icons/add_label_icon.png'
    });
    return $(".label_div_wrapper").hide();
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
      lat = obj.data("latitude");
      long = obj.data("longitude");
      return gmap(lat, long, zoom);
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
    if ($(".modal_window").length > 0) {
      modal_window();
    }
    $(".label_div ul li").live("click", function(event) {
      var id;
      id = $(this).attr("id");
      return $("#labels form").find("input#menu_label_association_menu_label_id").val(id).end().submit();
    });
    $("#desc_wrap #labels a.mi_add_label").live("click", function(event) {
      var new_left, new_top, offset;
      offset = $(this).position();
      new_top = parseInt(offset.top) + 12;
      new_left = parseInt(offset.left) - 84;
      $(".label_div_wrapper").css({
        "top": new_top
      }).css("left", new_left).show();
      return event.preventDefault();
    });
    if ($("#gallery").length > 0) {
      gallery_init;
    }
    $(document).ajaxComplete(function(event, xhr, settings) {
      if (settings.url === "/menu_label_associations") {
        if (xhr.responseText.indexOf('Warning') < 0 && xhr.responseText.indexOf("sign in") < 0) {
          $(".birdy_update").html(xhr.responseText);
        }
        return $(".label_div_wrapper").slideUp("fast");
      }
    });
    if (window.location.port.indexOf("300") > 0) {
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
