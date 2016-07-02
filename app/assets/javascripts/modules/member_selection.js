$.fn.member_selection = function() {
  var input = $(this).find("input");
  var output = $(this).find(".result");
  input.done_typing(function(){
    $.get("/user_list", {
      query: input.val()
      
    }).done(function(response) {
      output.html(response);
      output.initialize();
    });
  });
}