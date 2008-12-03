var boxList = [];

function showTopBox(id, src) {
	hideAll('.top_boxes', id);
	if( src != undefined ) {
		loadBox(src, id);
	}
	$(id).show();
}

function getAuthTokenParam() {
    return('authenticity_token=' + encodeURIComponent(globalURL.token));
}

function loadBox(src, elementId, extraQueryParams, forceRefresh){
  if(boxList[elementId] != undefined && forceRefresh != true)
      return;

  var  extraParams = "";
  if(extraQueryParams != undefined )
    extraParams = '&' + Object.toQueryString(extraQueryParams);
   
  new Ajax.Updater($(elementId), src, {
    asynchronous: true,
    evalScripts: true,
    method:'get',
    onLoading: function(){ 
      $(elementId).innerHTML = "<span style='padding:40px'><img src='/images/spinner.gif'/></span>";
    },
    onComplete: function(){
        boxList[elementId] = 1;
    },
    parameters: getAuthTokenParam() + extraParams
  });
}

function hideAll(selector, exceptId){
  var allSM = $$(selector);
  allSM.each(function(node){
    if( node.id != exceptId )
      node.hide();
  });
}

function toggleDDMenu(event) {
  var el = event.element();
  if(el.tagName == 'A')
    el = el.down();
    
  var menu_box = el.up().up().next().down();
  if( menu_box.visible() ) {
    newLabel = el.innerHTML.sub( "\u25BC", "\u25B6" );
    menu_box.hide();
  } else {
    menu_box.show();
    newLabel = el.innerHTML.sub( "\u25B6", "\u25BC" );
  }
  el.innerHTML = newLabel;
}

function createCartLine(cat_id) {
  qty = $('cart_item[' + cat_id + ']').value;
  new Ajax.Request(globalURL.cartLines, {
      asynchronous:true, 
      evalScripts:true, 
      method:'post',
      parameters:'cat_id=' + cat_id + '&qty=' + qty + '&' + getAuthTokenParam()
      } 
    );
}

function updateCartLine(op, id){
  new Ajax.Request(globalURL.cartLines, {
      asynchronous:true, 
      evalScripts:true, 
      method:'put',
      parameters:'id=' + id + '&op=' + op + '&' + getAuthTokenParam()
      } 
    );
}
