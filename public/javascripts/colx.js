
/*
Shows all boxes which ids are passed into this function
Hides all ".a_boxes" boxes 
 */
function boxLayout() {
  var outers = function(id){
	  if($(id + '_outer') == undefined)
		return id;
	  else
		return id + '_outer';	
	};	
	
  var theList = $A(arguments);
  var theListOuters = theList.map(outers);

  var toHide = $$('.a_boxes').pluck('id');
  var toHideOuters = toHide.map(outers);
  
  toHideOuters.each( function(el) {
    if(theListOuters.indexOf(el) == -1)
      $(el).hide();
  }); 
  
  theList.each(function(el){
  	loadBox(el)
  });
  
  theListOuters.each(function(el){
  	$(el).show()
  });
}


function makeColx(box_id, box_title) {
	var outer = new Element('div', {id: box_id + '_outer'});
	var theBox = $(box_id);
	
	theBox.wrap(outer);
	outer.insert({
		top: '<a href="#" class="c_box_headers" onClick="toggleBox(\'' + box_id + '\');return false;">' +
		'<span>&nbsp;&nbsp;&#x25BC;&nbsp;&nbsp;</span><span id="' +
		box_id +
		'_label">' +
		box_title +
		'</span></a>'
	});
	outer.addClassName('c_boxes');
	theBox.addClassName('c_box_context');
	if(!theBox.visible()){
		outer.hide();
		theBox.show();
	}
}

function toggleBox(el, op) {
  var theBox = $(el);
  var markBox = $(el + "_label").previous();
  var expanded = theBox.visible();
  label = markBox.innerHTML;
  
  if(op == undefined || op == 'toggle'){
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
  markBox.innerHTML = label;
}

