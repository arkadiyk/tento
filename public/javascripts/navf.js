

function goInfo() {
  goInfoH();
  dhtmlHistory.add('info', "goInfoH()");
}  

function goInfoH() {
  boxShow('info_box', 'cart_box', 'account_box');
  boxExpand('account_box');
  boxCollapse('cart_box');
}  
  
function goCatalog(cat, id) {
  var cid = cat + (id == undefined ? "" : "-" + id);
  goCatalogH(cid);
  dhtmlHistory.add('catalog~' + cid, "goCatalogH('" + cid +"')");
}  

function goCatalogH(id) {
  var box_id = "cat-" + id;
  boxShow(box_id,'cart_box','account_box');
  boxExpand('cart_box');
  boxCollapse('account_box');
}

function goCheckout() {
  goCheckoutH();
  dhtmlHistory.add('checkout', "goCheckoutH()");
}  

function goCheckoutH(id) {
  boxShow('checkout_box','account_box');
  boxExpand('account_box');
}