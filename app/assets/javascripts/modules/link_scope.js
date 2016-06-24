$.fn.link_scope = function() {
  $(this).click(function(e) {
    e.preventDefault();
    console.log($(this).attr("data-link-scope"));
    $("#"+$(this).attr("data-link-scope")).load($(this).attr("href"));
  });
}