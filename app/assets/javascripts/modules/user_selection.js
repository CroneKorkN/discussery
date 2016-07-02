$.fn.user_selection = function() {
  input = $(this).find("input");
  output = $(this).find(".result");
  input.done_typing(function(){
    $.get("/user_selection", {
      query: input.val()
    }).done(function(response) {
      output.html(response);
      output.initialize();
    });
  }, 200);
}