  var viewer = null;
 //testonly
 // var currentBook =0;
 // var currentNode =0;
  var currentChapterIndex=1; // second chapter
  var currentPageIdIndex=0; 
  var  imgPath = "/drupal/sites/default/files/images/deepzoom/book1/";
  var conf = "";
 
    function getCurrentId(){
	// TODO: check for existens
        console.log("current id => chapterId: "+currentChapterIndex+", pageId: "+currentPageIdIndex);
		id = chapters[currentChapterIndex].pageInfos[currentPageIdIndex].id; 
	   return id;
	}
    
    function getCurrentN(){
    
     console.log("current id => chapterId: "+currentChapterIndex+", pageId: "+currentPageIdIndex);
		id = chapters[currentChapterIndex].pageInfos[currentPageIdIndex].n; 
	   return id;
    
    }
    
    function getCurrentChapterId() {
    
     console.log("current id => chapterId: "+currentChapterIndex+", pageIndex: "+currentPageIdIndex);
		id = chapters[currentChapterIndex].chapterId; 
	   return id;
    
    
    }
    
    function existsIdFor(chapterIndex,pageIndex) {
     var id = chapters[chapterIndex].pageInfos[pageIndex].id; 
     var ex = !(id === undefined);
     console.log("exits id? "+ex);
     return ex;
    }

    function flipPagesGetId(pages, direction){
    
    console.log("before flipping page => chapterId: "+currentChapterIndex+", pageId: "+currentPageIdIndex+", direction:"+direction+", pages: "+pages);
    var cInfos    = chapters[currentChapterIndex].pageInfos;
	var nextIndex = currentPageIdIndex + (direction * pages);
    var nextChapterIndex = currentChapterIndex;
    
    // test if is next page is in current chapter
    if(cInfos[nextIndex] != undefined  && cInfos[nextIndex].id != undefined ) {
	     currentPageIdIndex = nextIndex;
	     return getCurrentId();	
     }
          
        // maybe in next chapter
      else  if(direction == 1) {
                    console.log("flip one chapter ahead?");
             // from 0 to n-1
             nextIndex =  pages-1;
             nextChapterIndex = currentChapterIndex+1;
                            //AND the chapter belongs to the same book
             if(existsIdFor(nextChapterIndex, nextIndex) === true && chapters[nextChapterIndex].book == currentBook){
              console.log("flip one chapter ahead");
              // change state
                currentPageIdIndex  = nextIndex ;
                currentChapterIndex = nextChapterIndex;
            }
               
            return getCurrentId();	
        }
          
        // maybe in  prevrious chapter
        else if(direction == -1) {
            console.log("flip one chapter back?");
          // last
        cInfos   = chapters[currentChapterIndex-1].pageInfos;
             // find last page nr of prev chapter,
             // minus the given pages
            nextIndex   =  parseInt(countPages(cInfos)) - pages;
            nextChapterIndex = currentChapterIndex-1;
             
             // test there is page exits AND the chapter belongs to the same book
             if(existsIdFor(nextChapterIndex, nextIndex) === true && chapters[nextChapterIndex].book == currentBook){
                console.log("flip one chapter back");
              // change state
                currentPageIdIndex  = nextIndex ;
                currentChapterIndex = nextChapterIndex;
            }
               
            return getCurrentId();	
          }
          
          // finaly do nothing or show sd error
          
          
  }
 
  function changeImage(id){
	
	if(id == undefined || id =="" ){
	// alert("next image not valid:"+id);
	 return;
	}
     var imgFile = imgPath + id +".dzi"; 
     console.log("try to open"+ imgFile);
/*
var xmlDzi= '<?xml version="1.0" encoding="utf-8"?>'
		+'<Image TileSize="256" Overlap="1" Format="jpg" ServerFormat="Default" xmnls="http://schemas.microsoft.com/deepzoom/2009">'
		+	'<Size Width="2667" Height="4500" /></Image>';
*/ 
    // use xml dzi as second parameter to avoid same origion policy problems if you're lading images from an ohter server
    //http://dragonosticism.wordpress.com/2008/11/25/seadragon-ajax-and-cross-site-scripting/
    // viewer.openDzi(imgFile,xmlDzi);
    
     viewer.openDzi(imgFile);
	     // update the titlebar with new pagenumber
    jQuery('#ImageviewerContainer').dialog('option', 'title', getTitleText());


//jQuery(dialog).dialog({position: ['top','left']  ,dialogClass: "flora"});
//jQuery('.flora.ui-dialog').css({position:"fixed"});

   }
   
   /**
   ** Returns the current page and chapter:
   **  Chapter(ENT00): 1 OF 11, Page: 1 OF 10 
   */
 function getTitleText(){
  // Chapter(ENT00): 1 OF 11, Page: 1 OF 10 , +1 because zero based index
   // var infoText = "Chapter("+chapters[currentChapterIndex].chapterId +"): "+ (currentChapterIndex+1) +" OF "+ chapters.length;
  //	infoText =  infoText  + ",  Page: "+ (currentPageIdIndex+1) +" OF "+ countPages(chapters[currentChapterIndex].pageInfos);
 
    /*var infoText = "Chapitre "+(currentChapterIndex+1) +", Page "+(currentPageIdIndex+1);
          console.log(infoText);*/
          
      var infoText = " P "+ getCurrentN() ;   
    return infoText;



}   

/*
* Returns the nr. of elements with numerirc key in the given @parmenter pageInfo
*
*/
 function countPages(pageInfo){
	//http://andrewdupont.net/2006/05/18/javascript-associative-arrays-considered-harmful/	
		var count=0;
		// count nr. of PageInfos starting at index 0 ...n
        // stop counting at the first non exisiting index n+1.  
		 while(true){
		  if (pageInfo[count] != undefined)
			count++;
		else
			break;	
		}
	return count;

	}
   
function initSeadragon() {
 /* simple
        jQuery('#ImageviewerContainer').css({ display: 'block', top: 50,left:20, 
                                'border-width': 3, 'border-style': 'solid',
                                backgroundcolor: 'white',
                                'border-color': 'black', height: conf.vh, width: conf.vw, position: 'fixed'});
                                */
    viewer = new Seadragon.Viewer("ImageviewerContainer");
    var c = makeControl();
       // for(i=0; i < c.length; ++i ){ 
      //    viewer.addControl(c[i],Seadragon.ControlAnchor.BOTTOM_LEFT);
     //     viewer.addControl(c[i],Seadragon.ControlAnchor.TOP_LEFT);
	//}
	  	
     var id = getCurrentId();
    changeImage(id);
    
    // check if an existing dialog has the sticky attribute
    var dialogIsSticky = jQuery('#ImageviewerContainer').dialog( "option", "sticky") === true;
    console.log("found an sticky dialog: "+dialogIsSticky);
    
	// start seadragon as jquery-ui dialog
    var dialog = jQuery('#ImageviewerContainer').dialog({
                    height: conf.vh,
                     width: conf.vw,
                     position: 'left',
                     title: getTitleText(),
                     sticky: dialogIsSticky
                     });
                     
                     /*
Specifies where the dialog should be displayed. Possible values:
1) a single string representing position within viewport: 'center', 'left', 'right', 'top', 'bottom'.
2) an array containing an x,y coordinate pair in pixel offset from left, top corner of viewport (e.g. [350,100])
3) an array containing x,y position string values (e.g. ['right','top'] for top right corner).                     
                     */
  
 //jQuery(dialog).parent().scrollFollow({speed: 10, offset:10, delay: 500});
 
}
  
     function makeControl() {
       var controlls = [];
 
/*
	// prev p
       var prevP = document.createElement("a");
       var prevPtext = document.createTextNode("\u2190");
       
 //      prevP.href = "#"; // so browser shows it as link
       prevP.className = "control";
       prevP.appendChild(prevPtext);
       
       Seadragon.Utils.addEvent(prevP, "click",onClickPrevPage);
       controlls.push(prevP); 


	// next p
       var nextP = document.createElement("a");
       var nextPtext = document.createTextNode("\u2192");
       
       nextP.className = "control";
       nextP.appendChild(nextPtext);
       
       Seadragon.Utils.addEvent(nextP, "click",onClickNextPage);
       controlls.push(nextP);  
 // arrows acii http://www.tlt.psu.edu/suggestions/international/web/codehtml.html
*/

var nextPage = new Seadragon.Button(
		"next page",
		Seadragon.Config.imagePath + "next-arrow-1.png",
		Seadragon.Config.imagePath + "next-arrow-1.png",
			Seadragon.Config.imagePath + "next-arrow-1.png",
			Seadragon.Config.imagePath + "next-arrow-1.png",
                null,       // do nothing on initialpress
		onClickNextPage,     //
		null,       // no need to use clickthresholds
		null,       // do nothing on enter
		null       // do nothing on exit
		);

var prevPage = new Seadragon.Button(
		"previous page",
		Seadragon.Config.imagePath + "prev-arrow-1.png",
		Seadragon.Config.imagePath + "prev-arrow-1.png",
			Seadragon.Config.imagePath + "prev-arrow-1.png",
			Seadragon.Config.imagePath + "prev-arrow-1.png",
                null,       // do nothing on initialpress
		onClickPrevPage,     // 
		null,       // no need to use clickthresholds
		null,       // do nothing on enter
		null       // do nothing on exit
		);
        
        
        // fix viewer while scrolling
        var fixViewer = new Seadragon.Button(
		"toogle to keep position while scrolling",
		Seadragon.Config.imagePath + "sticky.png",
		Seadragon.Config.imagePath + "sticky.png",
        Seadragon.Config.imagePath + "sticky.png",
        Seadragon.Config.imagePath + "sticky.png",
                null,       // do nothing on initialpress
		function () {toogleSticky(fixViewer.elmt)},     // 
		null,       // no need to use clickthresholds
		null,       // do nothing on enter
		null       // do nothing on exit
		);
        
        
        console.log("button:"+ fixViewer);
        console.dir(fixViewer);

        
      /*  
        // unfix viewer while scrolling
        var unfixViewer = new Seadragon.Button(
		"disable position while scrolling",
		Seadragon.Config.imagePath + "prev-arrow-1.png",
		Seadragon.Config.imagePath + "prev-arrow-1.png",
			Seadragon.Config.imagePath + "prev-arrow-1.png",
			Seadragon.Config.imagePath + "prev-arrow-1.png",
                null,       // do nothing on initialpress
		function () { jQuery( "#ImageviewerContainer" ).dialog( "option", "sticky", false);},     // 
		null,       // no need to use clickthresholds
		null,       // do nothing on enter
		null       // do nothing on exit
		);
*/
       var browseButtons =  new Seadragon.ButtonGroup([prevPage, nextPage]);
       viewer.addControl(browseButtons.elmt,Seadragon.ControlAnchor.BOTTOM_RIGHT);        

       var stickyButtons =  new Seadragon.ButtonGroup([fixViewer]);       
       viewer.addControl(stickyButtons.elmt,Seadragon.ControlAnchor.BOTTOM_LEFT); 

       return controlls;
     }


function toogleSticky(elmt) {

  var dialog = jQuery( "#ImageviewerContainer" );
  var isSticky = dialog.dialog( "option", "sticky");
  // toggle
  dialog.dialog( "option", "sticky", !isSticky);
  // change background if sticky is enabled

  if(!isSticky == true){
    jQuery(elmt).css('background','grey'); 
   }
   else {
     jQuery(elmt).css('background','none'); 
   }

  //TODO: change image of button


}


// functions to handle book navigation

      function onClickNextPage(event){
	console.log("clicked n page");
      var id = 	flipPagesGetId(1,1);
	  changeImage(id);
      }
	
      function onClickPrevPage(event){
	console.log("clicked p page");
      var id = 	flipPagesGetId(1,-1);
	  changeImage(id);
      }

      function onClickNextChapter(event){
	alert("clicked n ch");
      }
     
      function onClickPrevChapter(event){
	alert("clicked p ch");
      }

     function onControlClick(event) {
       Seadragon.Utils.cancelEvent(event); 
	 // don't process link
       if (!viewer.isOpen()) {
         return;
       }
     }
     
// create new Instance
/*function createSeadragon(){
createSeadragon("");
}*/

function createSeadragon(id,sdConf){
 conf = sdConf;
imgPath = sdConf.path;
findId(id);
console.log("image path is:"+imgPath);
// use icons from module for gui elements
//Seadragon.Config.imagePath = "/drupal/sites/all/modules/tei_imageviewer/img/";
 Seadragon.Config.imagePath = seadragonImagePath;
//TODO: add imagepath for buttons to sdConf
//Seadragon.Config.imagePath = "../img/";
Seadragon.Utils.addEvent(window, "load", initSeadragon);
initDialog();
initSeadragon();

}


/**
** Create a option sticky for all jQuery.ui.dialog's so the keep their position while scrolling  
** code from
**/
function initDialog() {
    jQuery
    var _init = jQuery.ui.dialog.prototype._init;
    jQuery.ui.dialog.prototype._init = function() {
    var self = this;
    _init.apply(this, arguments);
    this.uiDialog.bind('dragstop', function(event, ui) {
    if (self.options.sticky) {
    var left = Math.floor(ui.position.left) - jQuery
    (window).scrollLeft();
    var top = Math.floor(ui.position.top) - jQuery(window).scrollTop
    ();
    self.options.position = [left, top];
    };
    });
    if (window.__dialogWindowScrollHandled === undefined) {
    window.__dialogWindowScrollHandled = true;
    jQuery(window).scroll(function(e) {
    jQuery('.ui-dialog-content').each(function() {
    var isSticky = jQuery(this).dialog('option', 'sticky') && jQuery
    (this).dialog('isOpen');
    if (isSticky) {
    var position = jQuery(this).dialog('option','position');
    jQuery(this).dialog('option', 'position', position);
    };
    });
    });
    };
    };
//jQuery.ui.dialog.defaults.sticky = false;



}

function findCurrentChapter(bookId,pageId){

for(c=0; c < chapters.length; c++){
 var current=chapters[c].pageInfos; 
	console.dir(current);
	for (p in current){
  //for(p=0; p < current.length; p++){
	if(current[p].id == queryId ){
		// TODO: set index use state obj with get set or 
		currentChapterIndex = parseInt(c);
		currentPageIdIndex  = parseInt(p);
		console.log("found: "+queryId+", at c:"+c+", p:"+p);
		//break;
		return c;
	}
   }
 }

/*
chapters.filter(function(e) e.book == 3 && e.chapterId=="ENT01")[0].pageInfos.map(function (e) e)
*/


}

//broken: returns 

function findId(queryId){
// for each id in chapters
// find indexes for id
// else use first
//  like: id = chapters[currentChapterIndex].pageInfos[currentPageIdIndex].id; 
// chapters[1].pageInfos[0].id

for(c=0; c < chapters.length; c++){
    // find the current book
   if(chapters[c].book != currentBook){
    continue;
   }
   var current=chapters[c].pageInfos; 
	console.dir(current);
	for (p in current){
  //for(p=0; p < current.length; p++){
	if(current[p].id == queryId ){
		// TODO: set index use state obj with get set or 
		currentChapterIndex = parseInt(c);
		currentPageIdIndex  = parseInt(p);
		console.log("found: "+queryId+", at chapter index:"+c+", pageInfo index:"+p);
		//break;
		return true;
	}
   }
 }
 console.log("no match for:"+queryId+" found!");
}
