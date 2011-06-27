disher_review_wrapper = $("#reviews_wrapper")

window.is_logged_in = () ->
    if $(".fb_login a.not_signed").length == 0
        true
    else
        false

close_labels_selectbox = () ->
    $(".label_div_wrapper").slideUp("fast")
    hide_mask()

window.cl = (msg) ->
    console.log(msg)

window.hide_mask = () ->
    $('#mask').fadeOut("fast");

window.show_mask = () ->
#    $('#mask').show()
    $('#mask').fadeIn("fast");
window.close_modal = () ->
    $('#mask').fadeOut("fast");
    $('.modal_window').fadeOut("fast");

#    $('#mask').hide()
#    $('.modal_window').hide()


window.show_dialog = (title = "Please sign in", content) ->
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
        if is_logged_in()
            modal_id = $(@).attr('name')
            show_modal(modal_id)
        else
            show_modal()
            $("img[alt=Fb_sign_in]").parents(".modal_window").show().find(".modal_title").text("<h1>Please sign in</h1>")


	$('.close_modal').live "click", () ->
	    close_modal()
	    $(".label_div_wrapper").hide()



window.added_label = (menu_item_id) ->
    $.gritter.add({title:'Notification', text: menu_item_id+' Label was added!', image: '/images/icons/add_label_icon.png'});
    $(".label_div_wrapper").hide()


window.gmap = (lat, long, zoom = 10, coor_array = [[lat,long]]) ->
    latlng = new google.maps.LatLng(lat, long);
    myOptions = zoom: zoom, center: latlng, mapTypeId: google.maps.MapTypeId.ROADMAP, overviewMapControl: false, overviewMapControlOptions: false, panControl: false, scaleControl: false, zoomControl: false, keyboardShortcuts: false, mapTypeControl: false, streetViewControl: false;
    map = new google.maps.Map(document.getElementById("map"),myOptions)

    for ll in coor_array
#        g_notice("Lang Lat", ll[0]+"<br />"+ll[1])
        new google.maps.Marker({position: new google.maps.LatLng(ll[0], ll[1]), map: map })

before_send = (obj) ->
    obj.fadeTo("slow", .5)

after_send = (obj, html) ->
    obj.fadeTo("fast", 1)
    obj.html(html)


#window.menu_item_photos_uploaded = ()->
#    alert 1
window.update_reviews = (id_of_menu_item, limits = $(".two-col").attr("rel")) ->
    obj = $("#reviews_wrapper #update_place")
    $.ajax({url: "/items/"+id_of_menu_item+"/show_reviews?limit="+limits,
    beforeSend: () -> before_send(obj),
    success: (html) -> after_send(obj, html)})



window.g_notice = (type, text) ->
    $.gritter.add({title:type, text:text});


window.save_helpfull = () ->

window.unsave_menu_item = (id) ->

    if id
        path = $("#mid_"+id)
    else
        $(path).find("form").attr("rel",saved_item_id)

    $(path).removeClass("saved_item").addClass("not_saved_item")
#    g_notice("Notification", "Item unsaved!")

#    path = $("#flag_icons div.save_icon[id=mid_"+mid+"]")
#    $(path).find("form").attr("rel",saved_item_id)

#    $(path).removeClass("not_saved_item").addClass("saved_item")
#    g_notice("Notification", "Item saved!")

window.save_menu_item = (mid, saved_item_id) ->
    path = $("#flag_icons div.save_icon[id=mid_"+mid+"]")
    $(path).attr("rel",saved_item_id).find("form").attr("rel",saved_item_id)

    $(path).removeClass("not_saved_item").addClass("saved_item")
#    g_notice("Notification", "Item saved!")


window.add_review = (id_of_menu_item, msg) ->
    update_reviews(id_of_menu_item)
#    $("#comment_wrapper #submit_block .text").text("Submit")

    $("#comment_wrapper").slideUp("slow",() ->
        $(this).empty()
        $("<h1>#{msg}<h1>").appendTo("#comment_wrapper");
        couner_reviews = $("#text_column #rating span").text()
        $("#text_column #rating span").html(parseInt(couner_reviews)+1)
        $("#comment_wrapper").slideDown("normal")
        $("#comment_wrapper").removeClass("sending")
    )





window.set_gmap = (zoom = 10) ->
    cl "set map"

    ar = []
#    if restaurants || menu items page
    if $(".menu_items_location").length > 0 || $(".search_index").length > 0 || $(".restaurants_index").length > 0 || $(".user_saved_menu_items_index").length > 0
#        cl "if $(.menu_items_location).length > 0 || $(.restaurants_index) .length > 0"

        $(".restaurant_menu_item_wrapper").each () ->
            lat =  $(@).data("latitude")
            long =  $(@).data("longitude")

            ar.push([lat, long])
        lat =  ar[0][0]
        long = ar[0][1]
        gmap(lat, long, zoom, ar)
    else if $("#current_info_wrapper").length >0
#        cl "else if $(#current_info_wrapper).length >0"
        obj = $("#current_info_wrapper")

        lat =  obj.data("latitude")
        long = obj.data("longitude")
        gmap(lat, long, zoom)


window.make_unfollow = () ->
    $(".submit.submit_wrapper").removeClass("follow").addClass("unfollow").find(".text").text("Unfollow")
#    g_notice("Notification", "Now you are following!")
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


search_bind = () ->
    $(".first_search_input").keyup (e) ->
        if e.keyCode == 13
            $(@).parents("form").submit()

    $("#navigation_wrap_search #submit_block").click () ->  $(@).parents("form").submit()

#    if $("a #restaurant_icon.off.restbutton.search_index").length > 0 || $("a #dishes_icon.off.dishbutton.search_index").length > 0
#        loc = window.location.search
#
#        if loc.indexOf("search_restaurants=true") < 0
#            restaurant_search = loc+"&search_restaurants=true"
#        else
#            restaurant_search = loc
#        $("a #restaurant_icon.off.restbutton.search_index").click (e) ->
#            cl 2222
#            e.preventDefault()
#            window.location = restaurant_search



#        $("a #dishes_icon.off.dishbutton.search_index").click (e) ->
#            $("#navigation_wrap_search form").submit()
#            e.preventDefault()


window.thumbnail_resizing = () ->
    if $("#image_thumbnail_middle_size").length > 0

        if parseInt($("#gallery #photos_counter").text()) > 0
           cl source =  $("#gallery a").first().attr("href")
           img = $("#image_thumbnail_middle_size img")
           $(img).attr("src", source)

           $("#image_thumbnail_middle_size img").load () ->
            img = $("#image_thumbnail_middle_size img")

            width =  $(img).width()
            height = $(img).height()

            if width > height
                attr = "height"
            else
                attr = "width"

            $(img).attr("height", "140px").css("opacity", 1)





window.update_after_adding_item = (place_name) ->
    window.close_modal()
    url = "/items/show_menu_items_of_place?place_name="+place_name
    $.ajax({url: url, context: document.body, success: (msg) => $("#update_place_restaurants").fadeTo("fast",.6).delay(500).html(msg).delay(500).fadeTo("fast",1)});




select_all_checked_labels = () ->
    labels_array = []

    within = $("#distance_inputs input:checked").val()

    $(".labels_inputs input:checked").each () ->
        labels_array.push($(this).next("label").text())

    path = []

    if labels_array.length > 0
        path.push("labels="+labels_array.join("+"))


    if within && within.length > 0
        path.push("within="+within)

    category = $("#buttons_wrapper .on").attr("id").replace("_icon","")
    path.push("category="+category)
    queary = window.location.search.split("&")[0].split("=")[1]
    path.push("q="+queary)
    path.push("lat="+$("body").attr("data-latitude"))
    path.push("long="+$("body").attr("data-longitude"))

    cl path_total = "/search?"+path.join("&")
    $.ajax({url: path_total, type: "get", context: document.body});

filter_bind = () ->
    $("#filters a").click (e) ->
        obj = $("#toggled_filters")
        $(obj).slideToggle "fast", () ->
            $("#triangle").toggleClass("on")
            if $(this).is(":visible")
                $('.labels_inputs').columnize({columns: 3, cache: false}} if $(".labels_inputs .column").length == 0
        e.preventDefault()

    $("#distance_inputs input").live "click", () -> select_all_checked_labels()
    $(".labels_inputs input").live "click", () -> select_all_checked_labels()



columnizing = () ->
    $('.labels_inputs').columnize({columns: 4, cache: false}} if $(".labels_inputs .column").length == 0
    filter_bind()


$(document).ready ->

    search_bind()
    top_nav_bind()
    thumbnail_resizing()

    columnizing() if window.location.href.indexOf("search") > 0


    $("#navigation .left_corner").live "click", () ->
         window.location = $(@).next().attr("href")
#    add menu item submit
    $(".inputs_column #submit_block a").live "click", () ->
        window.close_modal()
    $(".inputs_column #submit_block .submit_wrapper").live "click", () ->
        $(@).parents("form").submit()

#    follow button press
    $(".follow").live "click", () ->
        if is_logged_in()
            $(@).removeClass("follow").addClass("unfollow")
            $(@).parents("form").submit()
        else
            show_dialog("Please sign in to follow!")


    window.pl_all() if $(".add_photos_inline a#plupload").length !=0

#add menu item in modal
    $(".text_input input#menu_item_name").keyup () ->
        if $(@).val().length != 0
            $("#add_photo_here").show()
        else
            cl 0
            $("#add_photo_here").hide()


#    show_dialog("title", "content")
    modal_window()
#    if $(".modal_window").length > 0

    gallery_init() if $("#gallery").length > 0

    $('#comment_wrapper .submit_wrapper').click (e) ->
        if $(@).parents("form").find("textarea").val().length > 3
            $(@).parents("form").submit()

    $('#input_comment textarea').focus (e) ->
        $(@).parents("form").find("#submit_block").show()


    #for respond_to :js
    $.ajaxSetup 'beforeSend': (xhr) -> xhr.setRequestHeader("Accept", "text/javascript")


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

        if is_logged_in()
            show_mask()
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
                hide_mask()
            else
                $(".label_div_wrapper").css("top": new_top).css("left",new_left).show()
        else
            show_dialog()
        event.preventDefault()




    $("#toggled_filters")
        .ajaxStart () ->
            $("#get_nearby_loading").show()
            $("#update_place_restaurants").fadeTo("slow",.5)
            $("#toggled_filters input").attr('disabled', "true");



    $("#comment_wrapper").ajaxStart () ->
        cl "ajax start"
        $("#comment_wrapper").addClass("sending")
        $("#comment_wrapper #submit_block .text").text("Submitting")


    $(document).ajaxComplete (event, xhr, settings) ->
        if settings.url.indexOf("ratings") > 0
            if xhr.responseText == "no_token"
                cl "no token"
                window.location = "/auth/facebook"



#            window.location = "/auth/facebook"

        if settings.url.indexOf("search") > 0
            $("#get_nearby_loading").hide()

            $("#toggled_filters input").removeAttr('disabled');
            $("#update_place_restaurants")
                .fadeTo("slow",1)
                .html(xhr.responseText)


        if settings.url == "/menu_label_associations"
            if xhr.responseText.indexOf('Warning') < 0 && xhr.responseText.indexOf("sign in") < 0
                $(".birdy_update").html(xhr.responseText)
            close_labels_selectbox()


#    $(document).ajaxError () -> $.gritter.add({title:"Error", text: "Ajax error!", image: "/images/error_icon.png", sticky: => true});


#   google maps in homepage neary

#    set_gmap(13) if $("#map").length >0




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




#    $(".current_user_is_following.f_button.unfollow").live "click", () ->
#        alert 1


    $(".unfollow").live "click", () ->
        this_obj = @
        f_id = $(this_obj).parents("form").find("input#user_following_following_user_id").val()

#        f_id =  $("form#new_user_following input#user_following_following_user_id").val()
        path = ("/following/"+f_id)
#
#        $.ajax({url: path ,type: "delete"})

        $.ajax({url: path, type: "delete", context: document.body,success: () => $(@).removeClass("unfollow").addClass("follow")});

#


    $(".saved_item.save_icon").live "click", () ->
        cl "saved icon"
        cl id = $(@).attr("rel")

        path = ("/saved/"+id)
        $.ajax({url: path ,type: "delete"})

#        f = $(@).find("form")
#        f.attr("method", "delete")
#        .attr("action", new_action)
#        .submit()

    $(".not_saved_item.save_icon").live "click", () ->
        cl f = $(this).find("form")
        cl new_action = "/saved/"+$(f).attr("rel")
        $(this).find("form").submit()
        $(this).unbind('click')


    $("#select_box_hint").click () ->
        $("#sort_by").find("ul").slideToggle("slow")

    $("#sort_by ul li").live "click", () ->
        $("#select_sorttype").val($(this).text());
        $("#sort_by ul").slideUp()

     $("#reviews_wrapper #show_more_button").live 'click', (e) ->

        id_of_menu_item = $(this).data("itemid")
        cl new_limits = $(this).data("next")

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
            path = "/saved/show_menu_items_saved?limit="+new_limits



        $.ajax({url: path,
        before_send: () -> before_fade(obj),
        success: (html) ->
            after_send(obj, html)
            $("#show_more_button").attr("data-next",new_limits*2)
            set_gmap(13)
#            $.get('/menu_items/update_map')

        });


    $("input[type=text]").focus () ->
        $(this).select()
