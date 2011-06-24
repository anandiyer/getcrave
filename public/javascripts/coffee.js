(function() {
  var after_send, before_send, close_labels_selectbox, disher_review_wrapper, error, geo, search_bind, top_nav_bind;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  disher_review_wrapper = $("#reviews_wrapper");
  window.is_logged_in = function() {
    if ($(".fb_login a.not_signed").length === 0) {
      return true;
    } else {
      return false;
    }
  };
  close_labels_selectbox = function() {
    $(".label_div_wrapper").slideUp("fast");
    return hide_mask();
  };
  window.cl = function(msg) {
    return console.log(msg);
  };
  window.hide_mask = function() {
    return $('#mask').fadeOut("fast");
  };
  window.show_mask = function() {
    return $('#mask').fadeIn("fast");
  };
  window.close_modal = function() {
    $('#mask').fadeOut("fast");
    return $('.modal_window').fadeOut("fast");
  };
  window.show_dialog = function(title, content) {
    if (title == null) {
      title = "Please sign in";
    }
    modal_window();
    show_modal("modal_window");
    $(".modal_window .modal_title h1").empty().text(title);
    if (content) {
      return $(".modal_window .clone_me").empty().html(content);
    }
  };
  window.show_modal = function(modal_id) {
    $('#mask').css({
      'display': 'block',
      opacity: 0
    });
    $('#mask').fadeTo("fast", 0.6).height($(document).height());
    $('#' + modal_id).fadeIn("fast");
    return window.pl_all($("form.uuid").attr("rel"));
  };
  window.modal_window = function() {
    var window_height, window_width;
    window_width = $(document).width();
    window_height = $(document).height();
    $('.modal_window').each(function() {
      var left, modal_height, modal_width;
      modal_height = $(this).outerHeight();
      modal_width = $(this).outerWidth();
      left = (window_width - modal_width) / 2;
      return $(this).css({
        'left': left
      });
    });
    return $('.activate_modal').click(function() {
      var modal_id;
      if (is_logged_in()) {
        modal_id = $(this).attr('name');
        return show_modal(modal_id);
      } else {
        show_modal();
        return $("img[alt=Fb_sign_in]").parents(".modal_window").show().find(".modal_title").text("<h1>Please sign in</h1>");
      }
    });
  };
  $('.close_modal').live("click", function() {
    close_modal();
    return $(".label_div_wrapper").hide();
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
  window.update_reviews = function(id_of_menu_item, limits) {
    var obj;
    if (limits == null) {
      limits = $(".two-col").attr("rel");
    }
    obj = $("#reviews_wrapper #update_place");
    return $.ajax({
      url: "/items/" + id_of_menu_item + "/show_reviews?limit=" + limits,
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
  window.unsave_menu_item = function(id) {
    var path;
    if (id) {
      path = $("#mid_" + id);
    } else {
      $(path).find("form").attr("rel", saved_item_id);
    }
    return $(path).removeClass("saved_item").addClass("not_saved_item");
  };
  window.save_menu_item = function(mid, saved_item_id) {
    var path;
    path = $("#flag_icons div.save_icon[id=mid_" + mid + "]");
    $(path).attr("rel", saved_item_id).find("form").attr("rel", saved_item_id);
    return $(path).removeClass("not_saved_item").addClass("saved_item");
  };
  window.add_review = function(id_of_menu_item, msg) {
    update_reviews(id_of_menu_item);
    return $("#comment_wrapper").slideUp("slow", function() {
      var couner_reviews;
      $(this).empty();
      $("<h1>" + msg + "<h1>").appendTo("#comment_wrapper");
      couner_reviews = $("#text_column #rating span").text();
      $("#text_column #rating span").html(parseInt(couner_reviews) + 1);
      $("#comment_wrapper").slideDown("normal");
      return $("#comment_wrapper").removeClass("sending");
    });
  };
  window.set_gmap = function(zoom) {
    var ar, lat, long, obj;
    if (zoom == null) {
      zoom = 10;
    }
    cl("set map");
    ar = [];
    if ($(".menu_items_location").length > 0 || $(".search_index").length > 0 || $(".restaurants_index").length > 0 || $(".user_saved_menu_items_index").length > 0) {
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
      obj = $("#current_info_wrapper");
      lat = obj.data("latitude");
      long = obj.data("longitude");
      return gmap(lat, long, zoom);
    }
  };
  window.make_unfollow = function() {
    return $(".submit.submit_wrapper").removeClass("follow").addClass("unfollow").find(".text").text("Unfollow");
  };
  window.gallery_init = function() {
    return $('#gallery a').lightBox({
      overlayBgColor: '#000',
      overlayOpacity: 0.4,
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
  top_nav_bind = function() {
    $("#navigation li.following a").click(function(e) {
      if ($(".fb_login a.not_signed").length !== 0) {
        show_dialog("Please sign in!");
        return e.preventDefault();
      }
    });
    return $("#navigation li.saved a").click(function(e) {
      if ($(".fb_login a.not_signed").length !== 0) {
        show_dialog("Please sign in!");
        return e.preventDefault();
      }
    });
  };
  search_bind = function() {
    var loc, restaurant_search;
    $(".first_search_input").keyup(function(e) {
      if (e.keyCode === 13) {
        return $(this).parents("form").submit();
      }
    });
    $("#navigation_wrap_search #submit_block").click(function() {
      return $(this).parents("form").submit();
    });
    if ($("a #restaurant_icon.off.restbutton.search_index").length > 0 || $("a #dishes_icon.off.dishbutton.search_index").length > 0) {
      loc = window.location.search;
      if (loc.indexOf("search_restaurants=true") < 0) {
        restaurant_search = loc + "&search_restaurants=true";
      } else {
        restaurant_search = loc;
      }
      $("a #restaurant_icon.off.restbutton.search_index").click(function(e) {
        cl(2222);
        e.preventDefault();
        return window.location = restaurant_search;
      });
      return $("a #dishes_icon.off.dishbutton.search_index").click(function(e) {
        $("#navigation_wrap_search form").submit();
        return e.preventDefault();
      });
    }
  };
  window.thumbnail_resizing = function() {
    var img, source;
    if ($("#image_thumbnail_middle_size").length > 0) {
      if (parseInt($("#gallery #photos_counter").text()) > 0) {
        cl(source = $("#gallery a").first().attr("href"));
        img = $("#image_thumbnail_middle_size img");
        $(img).attr("src", source);
        return $("#image_thumbnail_middle_size img").load(function() {
          var attr, height, width;
          img = $("#image_thumbnail_middle_size img");
          width = $(img).width();
          height = $(img).height();
          if (width > height) {
            attr = "height";
          } else {
            attr = "width";
          }
          return $(img).attr("height", "140px").css("opacity", 1);
        });
      }
    }
  };
  window.update_after_adding_item = function(place_name) {
    var url;
    window.close_modal();
    url = "/items/show_menu_items_of_place?place_name=" + place_name;
    return $.ajax({
      url: url,
      context: document.body,
      success: __bind(function(msg) {
        return $("#update_place_restaurants").fadeTo("fast", .6).delay(500).html(msg).delay(500).fadeTo("fast", 1);
      }, this)
    });
  };
  $(document).ready(function() {
    search_bind();
    top_nav_bind();
    thumbnail_resizing();
    $("#navigation .left_corner").live("click", function() {
      return window.location = $(this).next().attr("href");
    });
    $(".inputs_column #submit_block a").live("click", function() {
      return window.close_modal();
    });
    $(".inputs_column #submit_block .submit_wrapper").live("click", function() {
      return $(this).parents("form").submit();
    });
    $(".follow").live("click", function() {
      if (is_logged_in()) {
        $(this).removeClass("follow").addClass("unfollow");
        return $(this).parents("form").submit();
      } else {
        return show_dialog("Please sign in to follow!");
      }
    });
    if ($(".add_photos_inline a#plupload").length !== 0) {
      window.pl_all();
    }
    $(".text_input input#menu_item_name").keyup(function() {
      if ($(this).val().length !== 0) {
        return $("#add_photo_here").show();
      } else {
        cl(0);
        return $("#add_photo_here").hide();
      }
    });
    modal_window();
    if ($("#gallery").length > 0) {
      gallery_init();
    }
    $('#comment_wrapper .submit_wrapper').click(function(e) {
      if ($(this).parents("form").find("textarea").val().length > 3) {
        return $(this).parents("form").submit();
      }
    });
    $('#input_comment textarea').focus(function(e) {
      return $(this).parents("form").find("#submit_block").show();
    });
    $('textarea').autoResize();
    $("#labels a.label").live("click", function(event) {
      var id;
      id = $(this).attr("rel");
      return $("#labels form").find("input#menu_label_association_menu_label_id").val(id).end().submit();
    });
    $(".label_div ul li").live("click", function(event) {
      var id;
      id = $(this).attr("id");
      return $("#labels form").find("input#menu_label_association_menu_label_id").val(id).end().submit();
    });
    $("#desc_wrap a.mi_add_label").live("click", function(event) {
      var all_labels, new_left, new_top, offset;
      if (is_logged_in()) {
        show_mask();
        offset = $(this).position();
        new_top = parseInt(offset.top) + 12;
        new_left = parseInt(offset.left) - 84;
        all_labels = [];
        $(".label_item").each(function() {
          var exist;
          exist = $(this).text();
          all_labels.push(exist);
          return $(".label_div ul li").each(function() {
            if ($(this).text() === exist) {
              return $(this).remove();
            }
          });
        });
        if ($(".label_div ul li").length === 0) {
          $(".label_div_wrapper").hide();
          $.gritter.add({
            title: 'Notification',
            text: "All labels was added!"
          });
          hide_mask();
        } else {
          $(".label_div_wrapper").css({
            "top": new_top
          }).css("left", new_left).show();
        }
      } else {
        show_dialog();
      }
      return event.preventDefault();
    });
    $("#comment_wrapper").ajaxStart(function() {
      cl("ajax start");
      $("#comment_wrapper").addClass("sending");
      return $("#comment_wrapper #submit_block .text").text("Submitting");
    });
    $(document).ajaxComplete(function(event, xhr, settings) {
      if (settings.url === "/menu_label_associations") {
        if (xhr.responseText.indexOf('Warning') < 0 && xhr.responseText.indexOf("sign in") < 0) {
          $(".birdy_update").html(xhr.responseText);
        }
        return close_labels_selectbox();
      }
    });
    if ($("#map").length > 0) {
      set_gmap(13);
    }
    $(".yes_answer").live("click", function(event) {
      var form, found_helpfull_number, increment, link, link_text;
      event.preventDefault();
      if ($(this).find("a").length > 0 && $(".fb_login a.not_signed").length === 0) {
        link = $(this).find("a");
        link_text = $(link).text();
        $(this).find("span").html(link_text);
        found_helpfull_number = $(this).next();
        increment = parseInt(found_helpfull_number.text().replace(/[(|)]/ig, ""), 10) + 1;
        $(found_helpfull_number).text("(" + increment + ")");
        form = $(this).find("form");
        return form.submit();
      } else {
        return show_dialog("Please sign in!");
      }
    });
    $(".unfollow").live("click", function() {
      var f_id, path, this_obj;
      this_obj = this;
      f_id = $(this_obj).parents("form").find("input#user_following_following_user_id").val();
      path = "/following/" + f_id;
      return $.ajax({
        url: path,
        type: "delete",
        context: document.body,
        success: __bind(function() {
          return $(this).removeClass("unfollow").addClass("follow");
        }, this)
      });
    });
    $(".saved_item.save_icon").live("click", function() {
      var id, path;
      cl("saved icon");
      cl(id = $(this).attr("rel"));
      path = "/saved/" + id;
      return $.ajax({
        url: path,
        type: "delete"
      });
    });
    $(".not_saved_item.save_icon").live("click", function() {
      var f, new_action;
      cl(f = $(this).find("form"));
      cl(new_action = "/saved/" + $(f).attr("rel"));
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
      cl(new_limits = $(this).data("next"));
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
        path = "/saved/show_menu_items_saved?limit=" + new_limits;
      }
      return $.ajax({
        url: path,
        before_send: function() {
          return before_fade(obj);
        },
        success: function(html) {
          after_send(obj, html);
          $("#show_more_button").attr("data-next", new_limits * 2);
          return set_gmap(13);
        }
      });
    });
    return $("input[type=text]").focus(function() {
      return $(this).select();
    });
  });
}).call(this);
