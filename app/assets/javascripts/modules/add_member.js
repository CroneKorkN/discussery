$.fn.add_member = function() {
  $(this).click(function(){
    // prepare
    var group_id = $(".member_selection").data("group-id");
    var member_node = $(this).closest(".member");
    
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


