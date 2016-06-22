$.fn.answer = function() {
  $(this).click(function(){
    content = $("[data-answer-content]").html();
    topic_id = $(this).data("topic-id");
    $.ajax({
      type: "POST",
      url: "/topics/"+topic_id+"/posts",
      context: this,
      contentType: "application/json; charset=utf-8",
      data: '{"post":{"content":"'+content+'"}}',
      dataType: 'html',
    }).done(function(data) {
      $(".posts .new").before(data);
      content = $("[data-answer-content]").html("");
    });    
  });
}
