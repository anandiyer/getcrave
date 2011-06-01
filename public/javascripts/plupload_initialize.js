$(function() {
    if ($("a#plupload").length > 0 && $("#current_info_wrapper").data("menu_item_id")) {
        id = $("#current_info_wrapper").data("menu_item_id");
        path = "/menu_items/" + id + "/upload_photo";

        var uploader = new plupload.Uploader({
            runtimes : 'html5,flash',
            browse_button : 'plupload',
            max_file_size : '10mb',
            url : path,
            flash_swf_url : '/plupload/js/plupload.flash.swf',
            filters : [
                {title : "Image files", extensions : "jpg,gif,png"},

            ],
            init: {
                FileUploaded: function(up, file, info) {
                    //eval(info["response"]);

                    $("#gallery").html(info.response);
                    window.gallery_init();
                }
            }

        });

        uploader.bind('Init', function(up, params) {
//            console.log("init");
//		$('#filelist').html("<div>Current runtime: " + params.runtime + "</div>");
        });


        uploader.bind('UploadComplete', function(up, file) {
            $.gritter.add({title:"Notice", text: " Files was uploaded!"});
        });

        uploader.bind('BeforeUpload', function(up, file) {
            var signed = !$(".fb_login").find("a").hasClass("not_signed");
//            console.log("BeforeUpload");
//            console.log(signed);
            if (!signed){
                uploader.stop();
                window.show_dialog("Please, sign in to add photos!")
            }

        });

        uploader.bind('UploadProgress', function(up, file) {
            $('#' + file.id + " b").html(file.percent + "%");
//            $('#img_column .add_photos_inline').text(file.id)

        });

        uploader.init();

        uploader.bind('FilesAdded', function(up, files) {
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
});
