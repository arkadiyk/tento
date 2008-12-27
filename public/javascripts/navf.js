

function goInfo() {
  boxShow('info_box', 'cart_box', 'account_box');
  boxExpand('account_box');
  boxCollapse('cart_box');
}  
  

function goCatalog(cat, id) {
  var box_id = "cat-" + cat + (id == undefined ? "" : "-" + id);
  boxShow(box_id,'cart_box','account_box');
  boxExpand('cart_box');
  boxCollapse('account_box');
}
