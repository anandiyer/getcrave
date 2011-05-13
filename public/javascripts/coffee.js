(function() {
  $(document).ready(function() {
    return $("input[type=text]").focus(function() {
      return $(this).select();
    });
  });
}).call(this);
