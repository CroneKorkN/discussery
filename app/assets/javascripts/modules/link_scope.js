$.fn.link_scope = function() {
  $(this).click(function(e) {
    // supress default link action
    e.preventDefault();
    
    if ($(this).attr("data-link-scope")) {
      target_id = $(this).attr("data-link-scope");
    } else {
      target_id = "#page-content"
    }
    
    url = $(this).attr("href")
    history.pushState({},"URL Rewrite Example", url)
    $(target_id).load(url).initialize();

    // some logging
    console.log(target_id);
  });
}