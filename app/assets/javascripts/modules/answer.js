$.fn.answer = function() {
  $(this).click(function(){
    content = $("[data-answer-content]").html();
    id = $(this).data("postable-id");
    type = $(this).data("postable-type");
    $.ajax({
      type: "POST",
      url: "/posts",
      context: this,
      contentType: "application/json; charset=utf-8",
      data: '{"post":{"content":"'+content+'","postable_id":"'+id+'","postable_type":"'+type+'"}}',
      dataType: 'html',
    }).done(function(data) {
      $(".posts .new").before(data);
      content = $("[data-answer-content]").html("");
    });    
  });
}
