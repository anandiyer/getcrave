
window.pl_all = (function(uuid) {
    PATH = "";
    if ($("a#plupload").length > 0) {

        id = $("#current_info_wrapper").data("menu_item_id");
        console.log(uuid);
        path = "/items/" + id + "/upload_photo?uuid="+uuid+"?current_user_id="+$(".current_user").attr("rel");

        window.uploader = new plupload.Uploader({
            runtimes : 'html5',
            browse_button : 'plupload',
            max_file_size : '10mb',
            url : path,
//            flash_swf_url : '/plupload/js/plupload.flash.swf',
            filters : [
                {title : "Image files", extensions : "jpg,gif,png"},

            ],
            init: {
                FileUploaded: function(up, file, info) {
                    console.log(up);
                    console.log(file);
                    console.log(info);

                    $("#gallery").html(info.response);
                    window.gallery_init();
                }
            }

        });

        window.uploader.bind('Init', function(up, params) {
            console.log("init");

//		$('#filelist').html("<div>Current runtime: " + params.runtime + "</div>");
        });


        window.uploader.bind('UploadComplete', function(up, file) {
            $.gritter.add({title:"Notice", text: " Files was uploaded!"});
            
        });

        window.uploader.bind('BeforeUpload', function(up, file) {

//            if($(".modal_window .clone_me").length != 0){
//                if($("#menu_item_name").val().length == 0){
//                    uploader.stop();
//                    alert("Empty name field!")
//                }
//            }


            var signed = !$(".fb_login").find("a").hasClass("not_signed");

            if (!signed){
                uploader.stop();
                window.show_dialog("Please, sign in to add photos!")
            }

        });

        window.uploader.bind('UploadProgress', function(up, file) {
            $('#' + file.id + " b").html(file.percent + "%");
//            $('#img_column .add_photos_inline').text(file.id)

        });

        window.uploader.init();

        uploader.bind('FilesAdded', function(up, files) {
			$(".photos_inline").removeClass("himportant")
			
//            $.each(files, function(i, file) {
//                $('#filelist').append(
//                        '<div id="' + file.id + '">' +
//                                file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
//                                '</div>');
//                var txt = file.name + ' (' + plupload.formatSize(file.size) + ')';
//                console.log(txt)
//                window.g_notice = ("Notice", txt)
//                $.gritter.add({title:"Notice", text:txt});

//            });

            uploader.start();
        });
    }




    var availableTags = ($("#labels_all").text().split(","));


    function split( val ) {
        return val.split( /,\s*/ );
    }
    function extractLast( term ) {
        return split( term ).pop();
    }



    $( "#dish_label" )
    // don't navigate away from the field on tab when selecting an item
    .bind( "keydown", function( event ) {
        if ( event.keyCode === $.ui.keyCode.TAB &&
                $( this ).data( "autocomplete" ).menu.active ) {
            event.preventDefault();
        }
    })
    .autocomplete({
        minLength: 0,
        source: function( request, response ) {
            // delegate back to autocomplete, but extract the last term
            response( $.ui.autocomplete.filter(
                availableTags, extractLast( request.term ) ) );
        },
        focus: function() {
            // prevent value inserted on focus
            return false;
        },
        select: function( event, ui ) {
            var terms = split( this.value );
            // remove the current input
            terms.pop();
            // add the selected item
            terms.push( ui.item.value );
            // add placeholder to get the comma-and-space at the end
            terms.push( "" );
            this.value = terms.join( ", " );
            return false;
        }
    });




});
