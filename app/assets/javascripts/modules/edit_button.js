$.fn.edit_button = function() {
  $(this).click(function(){
    if ($("body").hasClass("editing")) {
      $("[data-editable-trigger=\"button\"]").editable(false);
      $("body").removeClass("editing");
    } else {
      $("[data-editable-trigger=\"button\"]").editable();
      $("body").addClass("editing");
    }
  });
}