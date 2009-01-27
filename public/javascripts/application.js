var boxList = {};

function boxReload() {
  $A(arguments).each( function(el) {
    loadBox(el, true);
  });
}

function boxRefresh() {
  $A(arguments).each( function(el) {
  	if(boxList[el] != undefined)
    	loadBox	(el, true);
  });
}


function getAuthTokenParam() {
    return('authenticity_token=' + encodeURIComponent(token));
}

function loadBox(elementId, reload){
      
  var els = elementId.split('-');
  var src = boxURL[els[0]];

  if(reload) {
    elementId = els[0];
    boxList[elementId] = undefined;
  }

  var forceRefresh = false;
  
  if(src == undefined)
    return;
  
  if(typeof(src) != "string") {
    forceRefresh = src.force;
    src = src.url;
  }
  
  if(boxList[elementId] != undefined && !forceRefresh)
      return;

  
  box = $(elementId);
  if( box == undefined ) {
    box = new Element('div', { id: elementId, 'class' : 'a_boxes'});
    $('center_col').insert(box);
  }
      
  var  extraParams = "";
  if(els.length > 1) {
    var extraQueryParams = new Hash();
    for(var i=1; i < els.length; i++){
      extraQueryParams.set('p' + i, els[i]);
    }
    extraParams = '&' + extraQueryParams.toQueryString();
  }

  new Ajax.Updater(box, src, {
    asynchronous: true,
    evalScripts: true,
    method:'get',
    onLoading: function(){ 
      box.innerHTML = "<span style='padding:40px'><img src='/images/spinner.gif'/></span>";
    },
    onSuccess: function(){
        boxList[elementId] = 1;
    },
    onFailure: function(){ 
      box.innerHTML = "<span style='padding:40px'>Communication problem. Please reload the page</span>";
    },

    parameters: getAuthTokenParam() + extraParams
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
  qty = $('cart_item_' + cat_id).value;
  unit_id = $('unit_id_' + cat_id).value;
  new Ajax.Request(boxURL.cart_box, {
      asynchronous:true, 
      evalScripts:true, 
      method:'post',
      parameters:'unit_id=' + unit_id + '&qty=' + qty + '&' + getAuthTokenParam()
      } 
    );
}

function updateCartLine(op, id){
  $('cart_line_' + id).addClassName('updating');
  
  new Ajax.Request(boxURL.cart_box, {
      asynchronous:true, 
      evalScripts:true, 
      method:'put',
      onSuccess: function(){
        $('cart_line_' + id).removeClassName('updating');
      },
      parameters:'id=' + id + '&op=' + op + '&' + getAuthTokenParam()
      } 
    );
}

function deleteCartLine(id){
  $('cart_line_' + id).addClassName('updating');

  new Ajax.Request(boxURL.cart_box, {
      asynchronous:true, 
      evalScripts:true, 
      method:'delete',
      parameters:'id=' + id + '&' + getAuthTokenParam()
      } 
    );
}



