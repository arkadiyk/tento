

function goInfo() {
  boxShow(['info_box', 'cart_box']);
}  
  

function goCatalog(cat, id) {
  var box_id = "cat-" + cat + (id == undefined ? "" : "-" + id);
  boxShow([box_id,'cart_box']);
}
