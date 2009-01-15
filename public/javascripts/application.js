var boxList = [];

function boxShow() {
  toHide = $$('.a_boxes');
  theList = $A(arguments);
  toHide.each( function(el) {
    if(theList.indexOf(el.id) == -1)
      el.hide();
  }); 
  
  theList.each( function(el) {
    loadBox(el);
    $(el).show();
  });
}

function boxReload() {
  $A(arguments).each( function(el) {
    loadBox(el, true);
  });
}

function boxCollapse() {
  $A(arguments).each( function(el) {
    toggleBox(el,'collapse');
  });
}

function boxExpand() {
  $A(arguments).each( function(el) {
    toggleBox(el,'expand');
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
  } else {
    boxC = $(elementId + '_context');
    if(boxC != undefined)
      box = boxC;
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
    onComplete: function(){
        $$('#' + elementId + ' .c_box_headers').each( function(el){ el.observe('click', handleToggleBox); } );
    },    
    onFailure: function(){ 
      box.innerHTML = "<span style='padding:40px'>Communication problem. Please reload the page</span>";
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

function handleToggleBox(event) {
  var el = event.element();
  if(el.tagName != 'A')
    el = el.up();
  
  toggleBox(el.up(), 'toggle');
};

function makeColx(box_id, box_title, extraOps) {
	if(extraOps == undefined)
		extraOps = {};
	extraOps.id = box_id + '_context'; 	
	var contextDiv = new Element('div', extraOps);

	contextDiv.update($(box_id).innerHTML);
	$(box_id).update('<a href="#" class="c_box_headers" onClick="return false;"><span>&nbsp;&nbsp;&#x25BC;&nbsp;&nbsp;</span><span id="' 
	+ box_id + '_label">' + box_title + '</span></a>');
  	$(box_id).insert(contextDiv);
	$(box_id).addClassName('c_boxes');
}

function toggleBox(el, op) {
  el = $(el);    
  var labelBox = el.down();
  var theBox = labelBox.next();
  var expanded = theBox.visible();
  label = labelBox.innerHTML;
  if(op == 'toggle'){
    if( expanded ) {
      label = label.sub( "\u25BC", "\u25B6" );
      theBox.hide();
    } else {
      theBox.show();
      label = label.sub( "\u25B6", "\u25BC" );
    }
  } else if (op == 'expand' && !expanded){
      theBox.show();
      label = label.sub( "\u25B6", "\u25BC" );
  } else if (op == 'collapse' && expanded) {
      label = label.sub( "\u25BC", "\u25B6" );
      theBox.hide();
  }
  labelBox.innerHTML = label;
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
  if( $('cart_line_' + id) != undefined ) {
    $('cart_line_' + id).addClassName('updating');
  }
  if( $('co_cart_line_' + id) != undefined ) {
    $('co_cart_line_' + id).addClassName('updating');
  }
  
  new Ajax.Request(boxURL.cart_box, {
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

  new Ajax.Request(boxURL.cart_box, {
      asynchronous:true, 
      evalScripts:true, 
      method:'delete',
      parameters:'id=' + id + '&' + getAuthTokenParam()
      } 
    );
}



