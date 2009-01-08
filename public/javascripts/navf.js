

function goInfo() {
  goInfoH();
  dhtmlHistory.add('h_info', "goInfoH()");
}  

function goInfoH() {
  boxShow('info_box', 'cart_box', 'account_box');
  boxExpand('account_box');
  boxCollapse('cart_box');
}  
  
function goCatalog(cat, id) {
  var box_id = "cat-" + cat + (id == undefined ? "" : "-" + id);
  goCatalogH(box_id);
  dhtmlHistory.add('h_' + box_id, "goCatalogH('" + box_id +"')");
}  

function goCatalogH(box_id) {
  boxShow(box_id,'cart_box','account_box');
  boxExpand('cart_box');
  boxCollapse('account_box');
}
