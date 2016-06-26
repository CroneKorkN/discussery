$.fn.toggle_menu = function() {
  $(this).click(function(){
    if($(this).hasClass("has-dropdown")) {
      var element = $(this).find("> .dropdown");  
    } else {
      var element = $($(this).attr("data-toggle"));  
    }
    element.toggle();
  });
}