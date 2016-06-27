$.fn.link_scope = function() {
  $(this).click(function(e) {
    // supress default link action
    e.preventDefault();
    
    // move active class
    $("a.active").removeClass("active");
    $(this).addClass("active");
        
    // define scope
    if ($(this).attr("data-link-scope")) {
      target_id = $(this).attr("data-link-scope");
    } else {
      target_id = "#page-content"
    }
    
    // get location
    url = $(this).attr("href")
    
    // cange address bar
    history.pushState({},"URL Rewrite Example", url)
    
    // do it!
    $(target_id).load(url).initialize();
  });
}