$.fn.add_member = function() {
  $(this).click(function(){
    // prepare
    group_id = $(".user_selection").data("group-id");
    
    // post
    $.post("/groups/"+group_id+"/memberships", {
      membership: {
        member_id: $(this).data("member-id"),
        member_type: $(this).data("member-type"),
      }
    }).done(function(response) {
      output.html(response);
      output.initialize();
    });
  });
}


