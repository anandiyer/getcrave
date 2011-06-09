disher_review_wrapper = $("#reviews_wrapper")


window.cl = (msg) ->
    console.log(msg)

window.close_modal = () ->
#    $('#mask').fadeOut("fast");
#    $('.modal_window').fadeOut("fast");

    $('#mask').hide()
    $('.modal_window').hide()


window.show_dialog = (title, content) ->
    modal_window()
    show_modal("modal_window")
    $(".modal_window .modal_title h1").empty().text(title)
    $(".modal_window .clone_me").empty().html(content) if content



window.show_modal = (modal_id) ->
    $('#mask').css({ 'display' : 'block', opacity : 0})

    $('#mask').fadeTo("fast",0.6).height($(document).height())
    $('#'+modal_id).fadeIn("fast")
    window.pl_all($("form.uuid").attr("rel"))




window.modal_window = () ->

    window_width = $(document).width()
    window_height = $(document).height()

    $('.modal_window').each () ->
        modal_height = $(@).outerHeight()
        modal_width = $(@).outerWidth()

#        top = (window_height-modal_height)/2
#        top = (window_height-modal_height)/2
        left = (window_width-modal_width)/2
        $(@).css({'left' : left})

    $('.activate_modal').click () ->
        modal_id = $(@).attr('name')
        show_modal(modal_id)


	$('.close_modal').live "click", () -> close_modal()



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


#window.menu_item_photos_uploaded = ()->
#    alert 1
window.update_reviews = (id_of_menu_item, limits = $("#show_more_button").data("step")) ->
    obj = $("#reviews_wrapper #update_place")
    $.ajax({url: "/menu_items/"+id_of_menu_item+"/show_reviews?limit="+limits,
    beforeSend: () -> before_send(obj),
    success: (html) -> after_send(obj, html)})



window.g_notice = (type, text) ->
    $.gritter.add({title:type, text:text});


window.save_helpfull = () ->



window.unsave_menu_item = () ->
    cl "unsave"
    cl path = $("#flag_icons div.save_icon")
#    $(path).find("form").attr("rel",saved_item_id)

    $(path).removeClass("saved_item").addClass("not_saved_item")
    g_notice("Notification", "Item unsaved!")

#    path = $("#flag_icons div.save_icon[id=mid_"+mid+"]")
#    $(path).find("form").attr("rel",saved_item_id)

#    $(path).removeClass("not_saved_item").addClass("saved_item")
#    g_notice("Notification", "Item saved!")

window.save_menu_item = (mid, saved_item_id) ->
    path = $("#flag_icons div.save_icon[id=mid_"+mid+"]")
    $(path).attr("rel",saved_item_id).find("form").attr("rel",saved_item_id)

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
    cl "set map"

    ar = []
#    if restaurants || menu items page
    if $(".menu_items_location").length > 0 || $(".search_index").length > 0 || $(".restaurants_index").length > 0 || $(".user_saved_menu_items_index").length > 0
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

        lat =  obj.data("latitude")
        long = obj.data("longitude")
        gmap(lat, long, zoom)


window.make_unfollow = () ->
    $(".submit.submit_wrapper").removeClass("follow").addClass("unfollow").find(".text").text("Unfollow")
    g_notice("Notification", "Now you are following!")
window.gallery_init = () ->
    $('#gallery a').lightBox
        overlayBgColor: '#000'
        overlayOpacity: 0.4
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



top_nav_bind = () ->
    $("#navigation li.following a").click (e) ->
        if $(".fb_login a.not_signed").length != 0
            show_dialog("Please sign in!")
            e.preventDefault()

    $("#navigation li.saved a").click (e) ->
        if $(".fb_login a.not_signed").length != 0
            show_dialog("Please sign in!")
            e.preventDefault()


$(document).ready ->


    #graphic submit
#    $(".submit_wrapper.submit").click () ->
#
#        $(@).parents("form").submit()



    top_nav_bind()



#    follow button press
    $("form .follow").live "click", () ->
        $(@).removeClass("follow").addClass("unfollow")
        $(@).parents("form").submit()

    window.pl_all() if $(".add_photos_inline a#plupload").length !=0

#add menu item in modal
    $(".text_input input#menu_item_name").keyup () ->
        if $(@).val().length != 0
            cl 1
            $("#add_photo_here").show()
        else
            cl 0
            $("#add_photo_here").hide()


#    show_dialog("title", "content")
    modal_window()
#    if $(".modal_window").length > 0

    gallery_init() if $("#gallery").length > 0

    $('#comment_wrapper .submit_wrapper').click (e) -> $(@).parents("form").submit()
#    $('#input_comment textarea').keydown (e) -> $(@).parents("form").submit() if (e.ctrlKey && e.keyCode == 13)


    $(document).ajaxSend (event, request, settings) ->
        if settings.type == 'post'
            settings.data = (settings.data ? settings.data + "&" : "") + "authenticity_token=" + encodeURIComponent( AUTH_TOKEN )
            request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    $.ajaxSetup({ beforeSend: (xhr) ->  xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))})



#   $('textarea').autoResize({onResize : () -> $(this).css({opacity:0.8}), animateCallback : () -> $(@).css({opacity:1}), animateDuration : 300, extraSpace : 40});
    $('textarea').autoResize()


#    ### labels
    $("#labels a.label").live "click", (event) ->
        id = $(@).attr("rel")

        $("#labels form")
            .find("input#menu_label_association_menu_label_id")
            .val(id)
            .end()
            .submit()



    $(".label_div ul li").live "click", (event) ->


        id = $(@).attr("id")
        $("#labels form")
            .find("input#menu_label_association_menu_label_id")
            .val(id)
            .end()
            .submit()

    $("#desc_wrap a.mi_add_label").live "click", (event) ->
        offset = $(@).position()
        new_top = parseInt(offset.top)+12
        new_left = parseInt(offset.left)-84




        all_labels = []


        $(".label_item").each () ->
            exist = $(@).text()
            all_labels.push(exist)

            $(".label_div ul li").each () ->
                if $(@).text() == exist
                    $(@).remove()


        if $(".label_div ul li").length == 0
            $(".label_div_wrapper").hide()
            $.gritter.add({title:'Notification', text: "All labels was added!"})
        else
            $(".label_div_wrapper").css("top": new_top).css("left",new_left).show()










        cl all_labels
        event.preventDefault()

    $(document).ajaxComplete (event, xhr, settings) ->
        if settings.url == "/menu_label_associations"
            if xhr.responseText.indexOf('Warning') < 0 && xhr.responseText.indexOf("sign in") < 0
                $(".birdy_update").html(xhr.responseText)
            $(".label_div_wrapper").slideUp("fast")

#    $(document).ajaxError () -> $.gritter.add({title:"Error", text: "Ajax error!", image: "/images/error_icon.png", sticky: => true});


#   google maps in homepage neary

    set_gmap(10)
#    if window.location.port.indexOf("3006") > 0



#    lat = 40.761447
#    long = -73.969456
#    gmap(lat, long, 7, [[lat, long],[lat,long+1]])


    $(".yes_answer").live "click", (event) ->

        event.preventDefault()
        if $(this).find("a").length > 0 && $(".fb_login a.not_signed").length == 0
            link = $(this).find("a")
            link_text = $(link).text()

            $(this).find("span").html(link_text)

            found_helpfull_number = $(this).next()
            increment = parseInt(found_helpfull_number.text().replace(/[(|)]/ig,""),10)+1
            $(found_helpfull_number).text("("+increment+")")
            form = $(this).find("form")
            form.submit()
        else
            show_dialog("Please sign in!")

    $(".saved_item.save_icon").live "click", () ->
        cl "saved icon"
        cl id = $(@).attr("rel")

        path = ("/user_saved_menu_items/"+id)
        $.ajax({url: path ,type: "delete"})

#        f = $(@).find("form")
#        f.attr("method", "delete")
#        .attr("action", new_action)
#        .submit()

    $(".not_saved_item.save_icon").live "click", () ->
        cl f = $(this).find("form")
        cl new_action = "/user_saved_menu_items/"+$(f).attr("rel")
        $(this).find("form").submit()
        $(this).unbind('click')


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
