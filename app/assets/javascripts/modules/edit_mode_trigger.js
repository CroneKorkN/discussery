$.fn.edit_mode_trigger = function() {
  $(this).change(function(){
    if (this.checked) {
      $("[data-editable-trigger=\"edit-mode\"]").editable();
      $("body").addClass("edit-mode");
    } else {
      $("[data-editable-trigger=\"edit-mode\"]").editable(false);
      $("body").removeClass("edit-mode");
    }
  });
  
  if (this.checked) {
    $("[data-editable-trigger=\"edit-mode\"]").editable();
    $("body").addClass("edit-mode");
  }
}