$(document).ready(function(){
    var uploader = new plupload.Uploader({
        runtimes : 'html5',
        browse_button : 'pickfiles',
        max_file_size : '10mb',
        url : '/menu_items/156434/upload_photo'
//        resize : {width : 320, height : 240, quality : 90},
//        flash_swf_url : '/javascripts/plugins/plupload/plupload.flash.swf',
//        filters : [
//            {title : "Image files", extensions : "jpg,gif,png"},
//        ]
    });

    uploader.bind('Init', function(up, params) {
//        alert(params.runtime)
        console.log(params.runtime)
        $('filelist').innerHTML = "<div>Current runtime: " + params.runtime + "</div>";
    });

    uploader.bind('FilesAdded', function(up, files) {
        console.log('FilesAdded')
        for (var i in files) {
            $('filelist').innerHTML += '<div id="' + files[i].id + '">' + files[i].name + ' (' + plupload.formatSize(files[i].size) + ') <b></b></div>';
        }
    });

    uploader.bind('UploadFile', function(up, file) {
        $('submit-form').innerHTML += '<input type="hidden" name="file-' + file.id + '" value="' + file.name + '" />';
    });

    uploader.bind('UploadProgress', function(up, file) {
        $(file.id).getElementsByTagName('b')[0].innerHTML = '<span>' + file.percent + "%</span>";
    });

    $('uploadfiles').onclick = function() {
        uploader.start();
        return false;
    };

    uploader.init();

})