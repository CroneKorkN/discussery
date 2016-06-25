$.fn.link_scope = function() {
  $(this).click(function(e) {
    // supress default link action
    e.preventDefault();
    
    target_element = $($(this).attr("data-link-scope"))
    url = $(this).attr("href")
    history.pushState({},"URL Rewrite Example",url)
    target_element.load(url);

    // some logging
    console.log($(this).attr("data-link-scope"));
  });
}