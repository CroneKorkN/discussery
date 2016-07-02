$.fn.add_member = function() {
  $(this).click(function(){
    // prepare
    group_id = $(".member_selection").data("group-id");
    member_node = $(this).closest(".user");
    
    // post
    $.post("/groups/"+group_id+"/memberships", {
      membership: {
        member_id: $(this).data("member-id"),
        member_type: $(this).data("member-type"),
      }
    }).done(function(response) {
      member_node.remove();
      $(".members").append(response);
    });
    $(this).closest(".user").remove();
  });
}


