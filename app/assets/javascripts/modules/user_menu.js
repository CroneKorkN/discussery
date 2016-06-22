$.fn.user_menu_trigger = function() {
  $(this).click(function(e){

    // ignore trigger default action
    if ($(e.target).is('a')) {
      e.preventDefault();
    }

    $(this).find(" > a").click(function(e) {
      e.preventDefault();
    });

    // toggle user-menu visibility
    var user_menu = $(".user-menu");
    if (user_menu.hasClass("hidden")) {
      user_menu.removeClass("hidden");
    } else {
      user_menu.addClass("hidden");
    }
  });

  return this;
}
