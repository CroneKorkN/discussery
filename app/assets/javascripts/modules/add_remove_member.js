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
      $(".members > :last-child").initialize();
    });
    $(this).closest(".user").remove();
  });
}

$.fn.remove_member = function() {
  $(this).click(function(){
    // prepare
    var membership_id = $(this).data("remove-member");
    l(membership_id);
    var member_node = $(this).closest(".member");
    
    // post
    $.ajax({
      url: "/memberships/"+membership_id,
      type: 'DELETE',
      success: function(result) {
        member_node.remove();
      }
    });
  });
}
