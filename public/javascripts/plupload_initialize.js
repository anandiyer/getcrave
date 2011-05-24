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

                    $("span#photos_counter").text(info.response);
                }
            }

        });

        uploader.bind('Init', function(up, params) {
//            console.log("init")
//		$('#filelist').html("<div>Current runtime: " + params.runtime + "</div>");
        });


        uploader.bind('UploadProgress', function(up, file) {
            $('#' + file.id + " b").html(file.percent + "%");
        });

        uploader.init();

        uploader.bind('FilesAdded', function(up, files) {
            $.each(files, function(i, file) {
                $('#filelist').append(
                        '<div id="' + file.id + '">' +
                                file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
                                '</div>');
            });
            uploader.start();
        });
    }
});
