$.fn.initialize = function() {
  console.log("initialize");

  $(this).find(".topic").topic();

  var editing = false;
  $(this).find("[data-edit]").edit_button();


  $(this).find(".has-dropdown").toggle_menu();
  $(this).find("[data-toggle]:not(.has-dropdown)").toggle_menu();
  
  $(this).find("a").link_scope();
}