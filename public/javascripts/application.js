boxList = [];

function showTopBox(id, src) {
	hideAll('.top_boxes', id);
	if( src != undefined ) {
		loadBox(src, id);
	}
	$(id).show();
}

function getAuthTokenParam() {
    var ati = document.getElementsByName("authenticity_token")[0];
    return('authenticity_token=' + encodeURIComponent(ati.value));
}

function loadBox(src, elementId, extraQueryParams, forceRefresh){
  if(boxList[elementId] != undefined && forceRefresh != true)
      return;

  if(extraQueryParams != undefined )
    extraParams = '&' + Object.toQueryString(extraQueryParams);
  else
    extraParams = "";
   
  new Ajax.Updater($(elementId), src, {
    asynchronous: true,
    evalScripts: true,
    method:'get',
    onComplete: function(){
        boxList[elementId] = 1;
    },
    parameters: getAuthTokenParam() + extraParams
  });
}

function hideAll(selector, exceptId){
  allSM = $$(selector);
  allSM.each(function(node){
    if( node.id != exceptId )
      node.hide();
  });
}
