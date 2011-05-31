disher_review_wrapper = $("#reviews_wrapper")


cl = (msg) ->
    console.log(msg)

window.added_label = (menu_item_id) ->
    $.gritter.add({title:'Notification', text: menu_item_id+' Label was added!', image: '/images/icons/add_label_icon.png'});
    $(".label_div_wrapper").hide()


window.gmap = (lat, long, zoom = 10, coor_array = [[lat,long]]) ->
    latlng = new google.maps.LatLng(lat, long);
    myOptions = zoom: zoom, center: latlng, mapTypeId: google.maps.MapTypeId.ROADMAP, overviewMapControl: false, overviewMapControlOptions: false, panControl: false, scaleControl: false, zoomControl: false, keyboardShortcuts: false, mapTypeControl: false, streetViewControl: false;
    map = new google.maps.Map(document.getElementById("map"),myOptions)

    for ll in coor_array
        g_notice("Lang Lat", ll[0]+"<br />"+ll[1])
        new google.maps.Marker({position: new google.maps.LatLng(ll[0], ll[1]), map: map })



before_send = (obj) ->
    obj.fadeTo("slow", .5)

after_send = (obj, html) ->
    obj.fadeTo("fast", 1)
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


window.set_gmap = (zoom = 10) ->
    cl "set_gmap"

    ar = []
#    if restaurants || menu items page
    if $(".menu_items_location").length > 0 || $(".restaurants_index").length > 0 || $(".user_saved_menu_items_index").length > 0
        cl "if $(.menu_items_location).length > 0 || $(.restaurants_index) .length > 0"

        $(".restaurant_menu_item_wrapper").each () ->
            lat =  $(@).data("latitude")
            long =  $(@).data("longitude")

            ar.push([lat, long])
        lat =  ar[0][0]
        long = ar[0][1]
        gmap(lat, long, zoom, ar)
    else if $("#current_info_wrapper").length >0
        cl "else if $(#current_info_wrapper).length >0"
        obj = $("#current_info_wrapper")

        cl lat =  obj.data("latitude")
        cl long = obj.data("longitude")
        gmap(lat, long, zoom)
    else
        cl "else"




window.gallery_init = () ->
    $('#gallery a').lightBox
        overlayBgColor: '#FFF'
        overlayOpacity: 0.6
        imageLoading: '/images/lightbox-ico-loading.gif'
        imageBtnClose: '/images/lightbox-btn-close.gif'
        imageBtnPrev: '/images/lightbox-btn-prev.gif'
        imageBtnNext: '/images/lightbox-btn-next.gif'
        containerResizeSpeed: 100
        txtImage: 'Imagem'
        txtOf: 'of'

error = (msg) ->
    $.gritter.add({title:"GEO Error", text: msg, image: "/images/error_icon.png", sticky: => true});


geo = (position) ->
    lat = position.coords.latitude
    long = position.coords.longitude



$(document).ready ->

#    if (navigator.geolocation)
#      navigator.geolocation.getCurrentPosition(geo, error)
#    else
#      cl error('not supported geo')



#    ### labels

    $(".label_div ul li").live "click", (event) ->
        id = $(this).attr("id")
        $("#labels form")
            .find("input#menu_label_association_menu_label_id")
            .val(id)
            .end()
            .submit()


    $("#desc_wrap #labels a").live "click", (event) ->

        offset = $(this).offset()
#        $(".label_div_wrapper").offset("{ top: "+offset.top+", left: "+offset.left+"}")
        $(".label_div_wrapper").offset({ top: offset.top+12, left: offset.left-84 }).slideDown()
        event.preventDefault()
#
#        label_div = $(".label_div")
#        if $(label_div).length == 0
#         $("body").add("div").addClass("label_div")

#    labels




    gallery_init if $("#gallery").length > 0


    $(document)
    .ajaxComplete (event, xhr, settings) ->
        if settings.url == "/menu_label_associations"
            if xhr.responseText.indexOf('Warning') < 0
                $(".birdy_update").html(xhr.responseText)
            $(".label_div_wrapper").slideUp("fast")

#    .ajaxError () ->
#        $.gritter.add({title:"Error", text: "Ajax error!", image: "/images/error_icon.png", sticky: => true});


#   google maps in homepage neary

    set_gmap(2) if window.location.port != "3005"



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

        id_of_menu_item = $(this).data("itemid")
        new_limits = $(this).data("next")

        if $(".menu_items_location").length > 0 || $(".restaurants_index").length > 0
           lat = $("body").data("latitude")
           long = $("body").data("longitude")

           obj = $("#update_place_restaurants")


           if $(".menu_items_location").length > 0
            path = "/menu_items/show_menu_items_nearby?lat="+lat+"&long="+long+"&limit="+new_limits
           else
            path = "/restaurants/show_restaurants_nearby?lat="+lat+"&long="+long+"&limit="+new_limits


        else if $(".menu_items_location").length > 0
            obj = $("#reviews_wrapper #update_place")
            path = "/menu_items/"+id_of_menu_item+"/show_reviews?limit="+new_limits
        else if $(".user_saved_menu_items_index").length > 0
            obj = $("#update_place_restaurants")
            path = "/user_saved_menu_items/show_menu_items_saved?limit="+new_limits



        $.ajax({url: path,
        before_send: () -> before_fade(obj),
        success: (html) ->
            after_send(obj, html)
            $("#show_more_button").attr("data-next",new_limits*2)
            set_gmap(8)
#            $.get('/menu_items/update_map')

        });


    $("input[type=text]").focus () ->
        $(this).select()
