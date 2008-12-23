var boxList = [];

function boxShow(boxIds) {
  toHide = $$('.center_boxes', '.right_boxes');
  toHide.each( function(el) {
    if(boxIds.indexOf(el.id) == -1)
      el.hide();
  }); 
  
  boxIds.each( function(el) {
    loadBox(el);
    $(el).show();
  });
}

function getAuthTokenParam() {
    return('authenticity_token=' + encodeURIComponent(token));
}

function loadBox(elementId){
      
  var els = elementId.split('-');
  var src = boxURL[els[0]];
  var forceRefresh = false;
  
  if(typeof(src) != "string") {
    forceRefresh = src.force;
    src = src.url;
  }

  if(boxList[elementId] != undefined && !forceRefresh)
      return;

  box = $(elementId);
  if( box == undefined ) {
    box = new Element('div', { id: elementId, 'class' : 'center_boxes'});
    $('main_box').insert(box);
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
      $(elementId).innerHTML = "<span style='padding:40px'><img src='/images/spinner.gif'/></span>";
    },
    onSuccess: function(){
        boxList[elementId] = 1;
    },
    onComplete: function(){
        $$('#' + elementId + ' .c_box_headers').each( function(el){ el.observe('click', toggleBox); } );
    },    
    onFailure: function(){ 
      $(elementId).innerHTML = "<span style='padding:40px'>Communication problem. Please reload the page</span>";
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

function toggleBox(event) {
  var el = event.element();
  if(el.tagName == 'A')
    el = el.down();
    
  var theBox = el.up().next();
  if( theBox.visible() ) {
    newLabel = el.innerHTML.sub( "\u25BC", "\u25B6" );
    theBox.hide();
  } else {
    theBox.show();
    newLabel = el.innerHTML.sub( "\u25B6", "\u25BC" );
  }
  el.innerHTML = newLabel;
}


function createCartLine(cat_id) {
  qty = $('cart_item_' + cat_id).value;
  new Ajax.Request(globalURL.cartLines, {
      asynchronous:true, 
      evalScripts:true, 
      method:'post',
      parameters:'cat_id=' + cat_id + '&qty=' + qty + '&' + getAuthTokenParam()
      } 
    );
}

function updateCartLine(op, id){
  if( $('cart_line_' + id) != undefined ) {
    $('cart_line_' + id).addClassName('updating');
  }
  if( $('co_cart_line_' + id) != undefined ) {
    $('co_cart_line_' + id).addClassName('updating');
  }
  
  new Ajax.Request(globalURL.cartLines, {
      asynchronous:true, 
      evalScripts:true, 
      method:'put',
      onSuccess: function(){
        if( $('cart_line_' + id) != undefined ) {
          $('cart_line_' + id).removeClassName('updating');
        }
        if( $('co_cart_line_' + id) != undefined ) {
          $('co_cart_line_' + id).removeClassName('updating');
        }
      },
      parameters:'id=' + id + '&op=' + op + '&' + getAuthTokenParam()
      } 
    );
}

function deleteCartLine(id){
  if( $('cart_line_' + id) != undefined ) {
    $('cart_line_' + id).addClassName('updating');
  }
  if( $('co_cart_line_' + id) != undefined ) {
    $('co_cart_line_' + id).addClassName('updating');
  }

  new Ajax.Request(globalURL.cartLines, {
      asynchronous:true, 
      evalScripts:true, 
      method:'delete',
      parameters:'id=' + id + '&' + getAuthTokenParam()
      } 
    );
}



