disher_review_wrapper = $("#reviews_wrapper")

window.gmap = (lat, long, zoom = 14) ->
    latlng = new google.maps.LatLng(lat, long);
    myOptions = zoom: zoom, center: latlng, mapTypeId: google.maps.MapTypeId.ROADMAP, overviewMapControl: false, overviewMapControlOptions: false, panControl: false, scaleControl: false, zoomControl: false, keyboardShortcuts: false, mapTypeControl: false, streetViewControl: false;
    map = new google.maps.Map(document.getElementById("map"),myOptions)
    marker = new google.maps.Marker({	position: new google.maps.LatLng(55.729999, 52.433219),	map: map })

before_send = (obj) ->
    obj.fadeTo("slow", .5)

after_send = (obj, html) ->
    obj.fadeTo("slow", 1)
    obj.html(html)

window.update_reviews = (id_of_menu_item, limits = $("#show_more_button").data("step")) ->
    obj = $("#reviews_wrapper #update_place")
    $.ajax({url: "/menu_items/"+id_of_menu_item+"/show_reviews?limit="+limits,
    beforeSend: () -> before_send(obj),
    success: (html) -> after_send(obj, html)})

window.add_review = (id_of_menu_item, msg) ->
    update_reviews(id_of_menu_item)
#    $.gritter.add({title:"Notification", text:msg});

    $("#comment_wrapper").slideUp("slow",() ->
        $(this).empty()
        $("<h1>#{msg}<h1>").appendTo("#comment_wrapper");
        $("#comment_wrapper").slideDown("slow")

    )


$(document).ready ->


    $("#select_box_hint").click () ->
        $("#sort_by").find("ul").slideToggle("slow")

    $("#sort_by ul li").live "click", () ->
        $("#select_sorttype").val($(this).text());
        $("#sort_by ul").slideUp()





     $("#reviews_wrapper #show_more_button").live 'click', (e) ->
        obj = $("#reviews_wrapper #update_place")
        id_of_menu_item = $(this).data("itemid")
        new_limits = $(this).data("next")



        $.ajax({url: "/menu_items/"+id_of_menu_item+"/show_reviews?limit="+new_limits,
        before_send: () -> before_fade(obj),
        success: (html) ->  after_send(obj, html); $("#show_more_button").attr("data-next",new_limits*2)});


    $("input[type=text]").focus () ->
        $(this).select()



#
#    $('#click').raty (score, evt) ->
#        path: "/images/"
#        alert('ID: ' + this.attr('id') + '\nscore: ' + score + '\nevent: ' + evt);