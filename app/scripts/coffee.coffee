##events binding class
#class Binding
#    select:
#
#        $("input[type=text]").focus () =>
#            $(this).select()
#        $('#click').raty (score, evt) ->
#            alert('ID: ' + this.attr('id') + '\nscore: ' + score + '\nevent: ' + evt);



$(document).ready ->
    $("input[type=text]").focus () ->
        $(this).select()
#
#    $('#click').raty (score, evt) ->
#        path: "/images/"
#        alert('ID: ' + this.attr('id') + '\nscore: ' + score + '\nevent: ' + evt);