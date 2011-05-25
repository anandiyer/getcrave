disher_review_wrapper = $("#reviews_wrapper")


cl = (msg) ->
    console.log(msg)

window.gmap = (lat, long, zoom = 10, coor_array = [[lat,long]]) ->
#window.gmap = (lat, long, zoom = 7) ->


    latlng = new google.maps.LatLng(lat, long);
    myOptions = zoom: zoom, center: latlng, mapTypeId: google.maps.MapTypeId.ROADMAP, overviewMapControl: false, overviewMapControlOptions: false, panControl: false, scaleControl: false, zoomControl: false, keyboardShortcuts: false, mapTypeControl: false, streetViewControl: false;
    map = new google.maps.Map(document.getElementById("map"),myOptions)

    for ll in coor_array
        new google.maps.Marker({position: new google.maps.LatLng(ll[0], ll[1]), map: map })



before_send = (obj) ->
    obj.fadeTo("slow", .5)

after_send = (obj, html) ->
    obj.fadeTo("slow", 1)
    obj.html(html)

window.menu_item_photos_uploaded = ()->
    alert 1
window.update_reviews = (id_of_menu_item, limits = $("#show_more_button").data("step")) ->
    obj = $("#reviews_wrapper #update_place")
    $.ajax({url: "/menu_items/"+id_of_menu_item+"/show_reviews?limit="+limits,
    beforeSend: () -> before_send(obj),
    success: (html) -> after_send(obj, html)})



window.g_notice = (type, text) ->
    $.gritter.add({title:type, text:text});


window.save_helpfull = () ->

window.save_menu_item = (mid) ->

    path = $("#flag_icons div.save_icon[id=mid_"+mid+"]")

    $(path).removeClass("not_saved_item").addClass("saved_item")
    g_notice("Notification", "Item saved!")

window.add_review = (id_of_menu_item, msg) ->
    update_reviews(id_of_menu_item)
#    $.gritter.add({title:"Notification", text:msg});

    $("#comment_wrapper").slideUp("slow",() ->
        $(this).empty()
        $("<h1>#{msg}<h1>").appendTo("#comment_wrapper");
        couner_reviews = $("#text_column #rating span").text()
        $("#text_column #rating span").html(parseInt(couner_reviews)+1)
        $("#comment_wrapper").slideDown("normal")
    )


window.set_gmap = (zoom = 4) ->
    ar = []
    if $(".restaurant_menu_item_wrapper.nearby").length > 0
        $(".restaurant_menu_item_wrapper.nearby").each () ->
            lat =  $(@).data("latitude")
            long =  $(@).data("longitude")

            ar.push([lat, long])
        lat =  ar[0][0]
        long = ar[0][1]
        gmap(lat, long, zoom, ar)

$(document).ready ->


    $(document).ajaxError () ->
        $.gritter.add({title:"Error", text: "Ajax error!", image: "/images/error_icon.png", sticky: => true});


#   google maps in homepage neary
    set_gmap(4)










#    lat = 40.761447
#    long = -73.969456
#    gmap(lat, long, 7, [[lat, long],[lat,long+1]])





    $(".yes_answer").live "click", (event) ->
        if $(this).find("a").length > 0
            event.preventDefault()
            link = $(this).find("a")
            link_text = $(link).text()

            $(this).find("span").html(link_text)

            found_helpfull_number = $(this).next()
            increment = parseInt(found_helpfull_number.text().replace(/[(|)]/ig,""),10)+1
            $(found_helpfull_number).text("("+increment+")")
            form = $(this).find("form")
            form.submit()


    $(".not_saved_item.save_icon").click () ->
        $(this).find("form").submit()
        $(this).unbind('click');


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