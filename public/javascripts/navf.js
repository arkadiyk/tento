

function goInfo() {
  boxShow('info_box', 'cart_box', 'user_box');
  boxExpand('user_box');
  boxCollapse('cart_box');
}  
  

function goCatalog(cat, id) {
  var box_id = "cat-" + cat + (id == undefined ? "" : "-" + id);
  boxShow(box_id,'cart_box','user_box');
  boxExpand('cart_box');
  boxCollapse('user_box');
}
