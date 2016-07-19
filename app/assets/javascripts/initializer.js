$.fn.initialize = function() {
  console.log("initialize");

  $(this).find(".topic").topic();

  $(this).find(".has-dropdown").toggle_menu();
  $(this).find("[data-toggle]:not(.has-dropdown)").toggle_menu();
  
  // $(this).find("a").link_scope();
  
  $(this).find("[data-edit-mode]").edit_mode_trigger();
  
  $(this).find(".member_selection").member_selection();
  
  $(this).find("[data-add-member]").add_member();
  $(this).find("[data-remove-member]").remove_member();
  
  key('shift+enter', function(){ 
    $("[data-send-answer]").trigger("click");  
  });
}
