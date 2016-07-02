$.fn.initialize = function() {
  console.log("initialize");

  $(this).find(".topic").topic();

  $(this).find(".has-dropdown").toggle_menu();
  $(this).find("[data-toggle]:not(.has-dropdown)").toggle_menu();
  
  // $(this).find("a").link_scope();
  
  $(this).find("[data-edit-mode]").edit_mode_trigger();
  
  $(this).find(".user_selection").user_selection();
  
  $(this).find("[data-add-member]").add_member();
}
