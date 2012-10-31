 (function ($) {


jQuery(document).ready(function ()
{
    createTeichiMenuBar();
});

/**
 * catch link clicks
 * and check if they're page links
 * if not ignore them
 */
Drupal.behaviors.teichi = {
attach:function (context, settings){
$('a',context).click(function(event){
if(this.href.indexOf('#p') >= 0)
{
event.preventDefault();
Drupal.teichidispatchPageLink(this.href.substr( (this.href.indexOf('#p')+2)) );
}
})
}
}; 


/**
** find pageInfos for pageID
**/
Drupal.teifindPageInfos = function (pageID){


	// create link to images
        // open popup with new seadragon
	//var f = function (){ 
//	var viewer = new Seadragon.Viewer("container");
//	viewer.openDzi("p1.dzi");
         // test
	 // display preview on hover
        // img: p1_files/8/0_0.jpg
	 var allA = $('a.pagelink');
   	console.log("all a tags:"+allA);
    	$.each(allA, function (i ,v){
          console.log("index:"+ i +" a tag:"+v);
	});


/*for(c in chapters){
  for( index in chapters[c].pageInfos ){
   console.log(chapters[c].pageInfos[index].id);
   }
  }*/
   
  // THINK: what kind of data we need later? chpapter index, info? As array or json or ...
  //TODO: try filter function:   jQuery.grep(, function(n, i) OR use a HASHMAP!
 // EDIT Seagragon to show stuff
  for(c in chapters){
      // console.log("c:"+c);
      for( key in chapters[c].pageInfos){
        //  console.log("info:"+key);
          var pInfo = chapters[c].pageInfos[key];
	  // console.log("info:"+pInfo);
            if(pInfo.id == pageID){
	            console.log("found:"+pageID+" in chapterNR:"+ c +", infos:"+ pInfo +"id:"+ pInfo.id +", n:"+ pInfo.n);
            }
 	} 

   }

/*
    for(i=0; i < chapters.length; i++) {
                // find matching id
                var 
             for(j=0; j < )
		if(currentNode==chapters[i].node && page >= chapters[i].start && page <= chapters[i].end) {
			window.location.href = Drupal.settings.basePath + 'node/' + currentNode + '#p' + page 
			return;
		}



*/

}



/**
 * looks up node number
 * for given page number
 * and calls the url of the node
 * @param page
 * @return
 */
Drupal.teichidispatchPageLink = function (page) {
  if(currentBook==0){
	for(i=0; i < chapters.length; i++) {
		if(currentNode==chapters[i].node && page >= chapters[i].start && page <= chapters[i].end) {
			window.location.href = Drupal.settings.basePath + 'node/' + currentNode + '#p' + page 
			return;
		}
	}
	alert(tPageNotAssigned+" ("+page+")");
  } else {
	for(i=0; i < chapters.length; i++) {
		if(page >= chapters[i].start && page <= chapters[i].end && currentBook == chapters[i].book) {
			window.location.href = Drupal.settings.basePath + 'node/' + chapters[i].node + '#p' + page; 
			return;
		}
	}
	alert(tPageNotAssigned+" ("+page+")");
  }
}

/**
 * toggle between text modes
 * @param how	display modus, String
 * @return	void
 */
Drupal.toggleView = function (how) // toggleView
{
	
	var toggle1 = document.getElementById('toggle1');
	var toggle2 = document.getElementById('toggle2');
	if(toggle1 && toggle2 && (how == 'orig' || how == 'sic'))
	{
	    $('.orig').show();
	    $('.sic').show();
	    $('.reg').hide();
	    $('.corr').hide();
	    toggle1.innerHTML = " <span id='activetextmode'>"+tRegText+"</span>";
	    toggle2.innerHTML = " <span id='passivetextmode'>"+tOrigText+"</span>";
	}else{
	    $('.orig').hide();
	    $('.sic').hide();
	    $('.reg').show();
	    $('.corr').show();
	    toggle1.innerHTML = " <span id='passivetextmode'>"+tRegText+"</span>";
	    toggle2.innerHTML = " <span id='activetextmode'>"+tOrigText+"</span>";
	}
		
}

/**
 * show/hide page index
 * @return void
 */
Drupal.teichiTogglePageIndex = function() 
{
	var pageindex = document.getElementById('pageindex');
	if(pageindex != null)
	{
		if(pageindex.style.display == 'none' || pageindex.style.display == '')
		{
		    pageindex.style.position = 'fixed';
		    pageindex.style.display = 'block';
			
		    //pageindex.style.left = $("a#teichiPageIndex").position().left;
		    var pindex = $(pageindex);
		    pindex.css('left', $("a#teichiPageIndex").position().left);
		    pindex.css('bottom', $("#teichisubmenucontainer").height());

		}else{
		    pageindex.style.display = 'none';
		}
			
	}
}


Drupal.teichiShowNote2 = function (nr) // showNote2
{
    var note = document.getElementById('note'+nr);
    if(note)
    {
	if(note.style.display == "block")
	{
	    Drupal.teichiHideNote(nr);
	    return;
	}	

	note.style.display = "block";

	if(note.parentNode)
	{
	    $('.note').css('z-index','0');
	    note.parentNode.style.zIndex = "10";
	    note.parentNode.style.overflow = "auto";
	}
    }

}

Drupal.teichiHideNote = function (nr) //hideNote(nr)
{
    var note = document.getElementById('note'+nr);
    if(note)
    {
	note.style.display = "none";
	if(note.parentNode)
	{
	    note.parentNode.style.zIndex = "0";
	    note.parentNode.style.overflow = "hidden";
	}
    }
}


function createTeichiMenuBar()
{
    var teichiMBarContainer = $( document.createElement('div') );
    var teichiMenubar = $( document.createElement('div') );
    var teichiPageIndex = $( document.createElement('a') );
    var teichiToggle1 = $( document.createElement('a') );
    var teichiToggle2 = $( document.createElement('a') );
    var tFormCon = document.createElement('form');
    tFormCon.setAttribute('onsubmit','javascript:Drupal.teichidispatchPageLink(this.pnr.value);return false;');
    var teichiPagesearch = $( tFormCon );
    var teichiInputField = $( document.createElement('input') );
    var teichiInputButton = $( document.createElement('input') );

    teichiMBarContainer.attr('id','teichisubmenucontainer');
    teichiMenubar.attr('id','submenu');
    teichiPageIndex.attr('href','javascript:Drupal.teichiTogglePageIndex();');
    teichiPageIndex.attr('id','teichiPageIndex');


    teichiPageIndex.append(document.createTextNode(tPageIndex));

    teichiToggle1.attr('id','toggle1');
    teichiToggle1.attr('href','javascript:Drupal.toggleView("reg");');

    teichiToggle1.append("<span id='passivetextmode'>"+tRegText+"</span>");
    teichiToggle2.attr('id','toggle2');
    teichiToggle2.attr('href','javascript:Drupal.toggleView("orig");');

    teichiToggle2.append("<span id='activetextmode'>"+tOrigText+ "</span>");

    teichiPagesearch.attr('id','pagesearch');
    teichiPagesearch.attr('name','pagesearch');
    //teichiPagesearch.attr('onsubmit','javascript:Drupal.teichidispatchPageLink(this.pnr.value);return false;');
    teichiInputField.attr('id','pnr');
    teichiInputField.attr('name','pnr');
    teichiInputField.attr('type','text');
    teichiInputField.attr('size','3');
    teichiInputField.attr('maxlength','3');

    teichiInputButton.attr('name','pnrsubmit');
    teichiInputButton.attr('type','submit');
    teichiInputButton.attr('value','OK');
    
    teichiPagesearch.append(teichiInputField);
    teichiPagesearch.append(teichiInputButton);

    teichiMenubar.append(teichiPageIndex);
    teichiMenubar.append(document.createTextNode(" | "));
    teichiMenubar.append(teichiToggle1);
    teichiMenubar.append(document.createTextNode(" | "));
    teichiMenubar.append(teichiToggle2);
    teichiMenubar.append(document.createTextNode(" | " + tGoto));
    teichiMenubar.append(teichiPagesearch);

    teichiMBarContainer.append(teichiMenubar);
    $('body').append(teichiMBarContainer);

}

})(jQuery);
