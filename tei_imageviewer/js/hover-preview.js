
var lastTop=0;
var lastScroll=0;

jQuery(document).ready(function ()
{
        /*
        jQuery(window).scroll(function (data) {
        
          var tops = jQuery(window).scrollTop();
          var dialog =  jQuery( "#container");
          console.log("topScroll() := "+tops+",dialog position:= "+jQuery(dialog).offset().top);
          console.log("w height:=" + jQuery(window).height());   // returns height of browser viewport
          console.log("doc height:=" + jQuery(document).height());   // returns height of html doc

          var diff = tops - lastTop;
          
          var actualPos = jQuery(dialog).offset();
           // scroll up
           if(diff<0){
            nextTopPos = actualPos.top + diff 
           }
           //scroll down
           else{
            nextTopPos = actualPos.top + diff            
           }
           
           
           if(Math.abs(diff) > 100) {
 //            jQuery( "#container").dialog( "option", "position", [0, 0] );
             lastTop = tops;
             console.log("-----rest");
          }
   });             
                
 */
});
/*
 //TODO: use tempelates prefix classes with tei-image!
  var toolTipHTML= " <div class='ImageviewerTooltip'> <img class='previewIMG' src='xxx.png' alt='open page in imageviwer'\>  </div>"; 
// var toolTipHTML= " <div class='ImageviewerTooltip'> <a class='pagelink'> <img class='previewIMG' src='xxx.png' alt='open page in imageviwer'\> </a>  </div>"; 
  var seadragonContainerHTML= "<div class='container'\>"; 
  jQuery('body').html(jQuery('body').html()+toolTipHTML+seadragonContainerHTML);
});*/


Drupal.extractId = function (a){
 var name = a.attr("name");
 if(!name){
    var txt=  a.attr("text");
   var s = txt.indexOf('.')+1;
   var e = txt.indexOf(']');
        console.log(s+","+e);
    name = 'p' + txt.substring(s,e);
 }
 return name;
}


//TODO: rename with respect to contrains
Drupal.changeIMG = function (a, bookPath) {
  var name = Drupal.extractId (a);
 // var bookPath = "/drupal/sites/default/files/images/deepzoom/book1/";
  var imgType = ".jpg";
  var id = bookPath + name + imgType;
	console.log("img with id:"+id);
  var offset = a.offset();

    jQuery(".ImageviewerTooltip").css({position: "absolute"});
    jQuery(".ImageviewerTooltip").offset({top: offset.top-190});
    
  console.log("offset"+offset.top +","+offset.left);

  var img = jQuery(".ImageviewerTooltip img");
      img.css("display","inline");  
      img.attr("src",id);
      
  console.log(img.offset().top+","+img.offset().left);
};

/**
 * catch link clicks
 * and check if they're page links
 * if not ignore them
 */
Drupal.behaviors.tei_imageviewer = { 
	attach:function (context, settings){
 
   // look for img path
   // defiend in viewer-conf.js
   
   // look for img path
   // defiend in viewer-conf.js
   var conf;
    // handle undefind variable TODO:BUG?
    if((typeof currentBook === "undefined")) {
	 var currentBook = 0;
	 console.log("undefined variable: currentBook");
	 conf = getConfig("default"); 
	}
	else {
	 conf = getConfig( String(currentBook));
	}
   
  console.log("use conf for book nr:"+currentBook);
  console.dir(conf); 
  
   // set css config
  //viewer
  jQuery(".container").css("width",conf.vw).css("height",conf.vh);

  //preview 			
  jQuery("img.previewIMG").css("width",conf.pw).css("height",conf.ph);

  // attach image preview for hover- and seadragon imageviewer for clickevents
  // to each link with class pagelink 
   jQuery("a.pagelink").each(function (){	
	var aj = jQuery(this);
        aj.removeAttr("href"); 
	aj.mouseenter( function () {
			// if(jQuery.cookie("usePreview") != "true")
            // only show preview if checkbox is checked
            if(jQuery("input[name=usePreview]").attr("checked") != true)
	                     return;
            else
		        Drupal.changeIMG(aj,conf.path);
		      });

        aj.mouseleave( function () {
			  //jQuery(".tooltip img").css("visibility","hidden");
              Drupal.closeTooltip();
			});  

     aj.click(function(e){
		e.preventDefault();
  	// use seadragon if user cookie is set
                //if(jQuery.cookie("useViewer") != "true")
  	// use seadragon if user checkbox is set                
        if(jQuery("input[name=useViewer]").attr("checked") != true){
                    return;
            }
                   
        // close open tooltip / preview
        Drupal.closeTooltip();
        var id = (Drupal.extractId(aj));
        createSeadragon(id , conf);
		console.log("start seadragon ...");		
     });	 
   // end each link
   }); 


    // read cookie or create it if not exsits
     if(jQuery.cookie("usePreview") == null){
         jQuery.cookie("usePreview", true);
       }
       
      if(jQuery.cookie("useViewer") == null){
          jQuery.cookie("useViewer", true);
      }
      
        // show selected preferences
    Drupal.updateUserPrefernce(); 

    // add listener to save users preference
    jQuery("div#viewerConf  :button").click(function() {
       Drupal.storeUserPrefernce(); 
    });
        // open viewer with first page of chapter on buttenclick
     jQuery("div#openViewer  :button").click(function() {
      Drupal.openFirstPage();
     });


 }
}

/**
** 
**/
Drupal.closeTooltip = function () {

 jQuery(".ImageviewerTooltip img").css("display","none");

}
/**
* open the first Page with Seadragon
**/
Drupal.openFirstPage = function (){
      var firstLink =  jQuery("a.pagelink").first();
      var conf = getConfig( (currentBook === undefined) ? "default"  :   String(currentBook));
      Drupal.closeTooltip();
      createSeadragon( Drupal.extractId(firstLink), conf);
      console.log("start seadragon ...");	    
}

/**
* store users preference to use preview and imageviewer in a cookie
**/
 Drupal.storeUserPrefernce = function () {
   var usePreview = jQuery("input[name=usePreview]").attr("checked");
     
      // store boolan as String in cookie
      jQuery.cookie("usePreview",usePreview);

     var useViewer  = jQuery("input[name=useViewer]").attr("checked");
            
      jQuery.cookie("useViewer",useViewer);

    console.log("change user conf => usePreview:"+usePreview +", useViewer:"+useViewer);
    Drupal.updateUserPrefernce(); 
 }
  
/**
*  Get  users preferences from cookie and show them as checkbox in the tei_imageviewer block
**/
 Drupal.updateUserPrefernce = function () {
  // store users prefernce to use preview  and imageviewer
     var cP  =  jQuery.cookie("usePreview");
     var cV  =  jQuery.cookie("useViewer");
   // cast cookie stings / null to booleanvalues
   // null   => true
   // 'true' => true
   // 'false'  => false
      jQuery("input[name=usePreview]").attr("checked", cP  == 'false' ? false : true);
      jQuery("input[name=useViewer]").attr("checked",  cV  == 'false' ? false : true);

   console.log("preference checkbox => usePreview:"+ jQuery("input[name=usePreview]").attr("checked") +", useViewer:"+ jQuery("input[name=useViewer]").attr("checked"));
}

