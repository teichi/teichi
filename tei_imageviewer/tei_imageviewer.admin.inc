<?php

/**
* @file
* Administration page callbacks for the annotate module.
*/

//TODO: clean file: Remove Code from tutorial module! is this code used at all?


/**
* Form builder. Configure annotations.
*
* @ingroup forms
* @see system_settings_form().
*/

function tei_imageviewer_admin_settings() {
  // Get an array of node types with internal names as keys and
  // "friendly names" as values. E.g.,
  // array('page' => ÕBasic Page, 'article' => 'Articles')
  $types = node_type_get_types();
  foreach($types as $node_type) {
    $options[$node_type->type] = $node_type->name;
  }

  $form['tei_imageviewer_node_types'] = array(
    '#type' => 'checkboxes',
    '#title' => t('Users may annotate these content types'),
    '#options' => $options,
    '#default_value' => variable_get('tei_imageviewer_node_types', array('page')),
    '#description' => t('A text field will be available on these content types to make user-specific notes.'),
  );

  $form['tei_imageviewer_deletion'] = array(
    '#type' => 'radios',
    '#title' => t('Annotations will be deleted'),
    '#description' => t('Select a method for deleting annotations.'),
    '#options' => array(
      t('Never'),
      t('Randomly'),
      t('After 30 days')
    ),
  '#default_value' => variable_get('tei_imageviewer_deletion', 0) // Default to Never
  );
  $form['tei_imageviewer_limit_per_node'] = array(
    '#type' => 'textfield',
    '#title' => t('Annotations per node'),
    '#description' => t('Enter the maximum number of annotations allowed per node (0 for no limit).'),
    '#default_value' => variable_get('tei_imageviewer_limit_per_node', 1),
    '#size' => 3
  );

 $form['tei_imageviewer_default_img_path'] = array(
    '#type' => 'textfield',
    '#title' => t('Default image path'),
    '#description' => t('Defaultpath where the deepzoom images are stored.'),
    '#default_value' => variable_get('tei_imageviewer_default_img_path','/drupal/sites/default/files/images/deepzoom/book1/' ),
    '#size' => 150 
  );

  $form['#submit'][] = 'tei_imageviewer_admin_settings_submit';
 

 //debug( _teicontent_get_books(),null,true );
 // for each book show imagepath
 foreach ( _teicontent_get_books() as $key => $value) {
  $form_key = 'tei_imageviewer_img_path_' .$key ;
  //debug($key."->".$value);
  $form[$form_key] = array(
    '#type' => 'textfield',
    '#title' => t('Default image path' . $key),
    '#description' => t('Defaultpath where the deepzoom images are stored.'),
    '#default_value' => variable_get( $form_key , '/drupal/sites/default/files/images/deepzoom/book1/' ),
    '#size' => 150 
  );
 }
 
 // join stored prefs with actual books
 // => take from books only the 

/*	// get all books
 $form['tei_imageviewer_booksettings'] = array(
    '#title' => t('Book'),
    '#type' => 'select',
   // '#options' => book_get_books(),
    '#options'     =>   _teicontent_get_books(),
    '#description' => t('Change settings for a Book'),
  );
*/
 tei_imageviewer_update_img_path();

  return system_settings_form($form, TRUE);

}

// import

function tei_imageviewer_book_settings_form($form, &$form_state) {
// needs to be changed if path changes
 $bid = arg(6);
//debug("bid:".$bid);
/*** imagepath ****/
  $form['tei_imageviewer_imagepath_'.$bid] = array(
    '#type' => 'textfield',
    '#title' => t('Imagepath for books:  '.$bid),
    '#description' => t('imagepath where the deepzoom images are stored.'),
    '#default_value' => variable_get('tei_imageviewer_imagepath_'.$bid, variable_get('tei_imageviewer_imagepath_default')),
    '#size' => 150,
    '#element_validate' => array('_validate_form_trailing_slash'),
  );

/**** preview with ****/
 $form['tei_imageviewer_pw_'.$bid] = array(
    '#type' => 'textfield',
    '#title' => t('Imagepreview with for book: '.$bid),
    '#default_value' => variable_get('tei_imageviewer_pw_'.$bid, variable_get('tei_imageviewer_pw_default')),
    '#size' => 5 
  );
/*** preview height ****/
 $form['tei_imageviewer_ph_'.$bid] = array(
    '#type' => 'textfield',
   '#title' => t('Imagepreview height for book: '.$bid),
    '#default_value' => variable_get('tei_imageviewer_ph_'.$bid, variable_get('tei_imageviewer_ph_default')),
    '#size' => 5
  );
/*** viewer width***/
 $form['tei_imageviewer_vw_'.$bid] = array(
    '#type' => 'textfield',
   '#title' => t('Imageviewer with for book: '.$bid),
    '#default_value' => variable_get('tei_imageviewer_vw_'.$bid, variable_get('tei_imageviewer_vw_default')),
    '#size' => 5,
    '#element_validate' => array('_validate_form_isNumeric'),
  );


/*** viewer height***/
 $form['tei_imageviewer_vh_'.$bid] = array(
    '#type' => 'textfield',
    '#title' => t('Imageviewer height for book: '.$bid),
    '#default_value' => variable_get('tei_imageviewer_vh_'.$bid, variable_get('tei_imageviewer_vh_default')),
    '#size' => 5,
    '#element_validate' => array('_validate_form_isNumeric'),
  );


// call tei_imageviewer_settings_as_json() to update frontend configration
 $system_from = system_settings_form($form);
 array_push( $system_from['#submit'], 'tei_imageviewer_settings_as_json') ;


 return $system_from;

}

/*validation functions*/

 
/**
validate a elment: assert that the value is numeric and positiv.
**/
function _validate_form_isNumeric($element, &$form_state) {
//  debug($element);
//  debug($form_state); 
  if (empty($element['#value']) || !is_numeric($element['#value']) || floatval($element['#value']) < 0 ) {
    form_error($element, t('The "@name"  option must contain a positiv numeric value without a unit like em or px.', array('@name' => t($element['#title']))));
  }
} 


function _validate_form_trailing_slash($element, &$form_state) {
//  debug($element);
//  debug($form_state); 
  if (empty($element['#value']) || substr($element['#value'],-1) != '/') {
    form_error($element, t('A folderpath must end with a traling slash: "/"') );
   // $element['#value'] = $element['#value'] . '/';
  }
} 







/*only applyed to new created nodes
function tei_imageviewer_validate($form, &$form_state) {
  debug($form);
  debug($form_state); 

}
*/

function tei_imageviewer_update_img_path() {
  $path = 'files/images/deepzoom/book1/';
  $url =  drupal_realpath('public://' .$path);
  if($url == false){
   watchdog(WATCHDOG_WARNING,"error in path!");
  }
  debug("real url for $path: " . $url);
  debug("dir:". base_path() . $directory .'/');

}


function _default_path_array() {
 $paths = array(
  'default' => 'files/images/deepzoom/book1/'
 );

 return $paths;
}



function tei_imageviewer_size_form($form, &$form_state) {

  $form['sizes'] = array(
    '#title' => t('Sizes'),
    '#type' => 'fieldset',
    '#description' => t('Size .<br/>Possible units are <b>px</b>,<b>pt</b>,<b>%</b> etc.'),
    '#collapsible' => TRUE,
    '#collapsed' => TRUE
  );
  $form['sizes']['tei_imageviewer_viewer_width'] = array(
    '#title' => t('Viewers Width'),
    '#type' => 'textfield',
    '#size' => 10,
    '#default_value' => variable_get('tei_imageviewer_viewer_width', '300px'),
    '#description' => t('Viewers with')
  );

  $form['sizes']['tei_imageviewer_preview_width'] = array(
    '#title' => t('Previews Width'),
    '#type' => 'textfield',
    '#size' => 10,
    '#default_value' => variable_get('tei_imageviewer_preview_width', '200px'),
    '#description' => t('Previews with')
  );



 $form['#submit'][] = 'tei_imageviewer_admin_settings_submit';

// tei_imageviewer_write_css();
 // add variable persitance and submit button
return system_settings_form($form, TRUE);
}


/**
* Item that calls @see tei_imageviewer_reparse_teinodes
**/
function tei_imageviewer_parse_teinodes_form($form, &$form_state) {
tei_imageviewer_reparse_teinodes();
return $form;

}


/**
* Reparse all nodes with type/filter teichi
*
**/
function tei_imageviewer_reparse_teinodes() {
  _teicontent_update_node_infos();
  drupal_set_message( t('TEI Imageviewer: parsed and updated all TEI Nodes'), 'status');
  tei_imageviewer_settings_as_json();
}



// write css with users settings

function tei_imageviewer_write_css() {
//TODO: remove funtion!

return ;


//depricated
$tei_imageviewer_preview_width = variable_get('tei_imageviewer_preview_width', '200px');
$tei_imageviewer_viewer_width  = variable_get('tei_imageviewer_viewer_width', '300px');

$css=<<<CSS

/** #### Tooltip  #### */
div.tooltipDiv {
 display: none;
 z-index: 5;
 ;border-width: 3em;
 ;border-style: dashed;
 ; width: 200px;
 ;height: 300px;
;border-style: solid;
;border-color: blue; 
 }

img.previewIMG{
 width: {$tei_imageviewer_preview_width};
 height: 300px;
visibility:hidden;
border-width: 3px;
border-style: solid;
border-color: black;
z-index: 900;
}

/*### seadragon ####*/

.container
      {
        width: {$tei_imageviewer_viewer_width};
        height: 600px;
        background-color: black;
        border: 1px solid black;
        color: white;  /* for error messages, etc. */
//	display:none;
      }
      .overlay
      {
        font-weight: bold;
        margin-top: 4px;
        margin-right: 4px;
      }
      .control{
 	 padding-left:10px;
 	 padding-right:10px;
	}

}

 
CSS;
//write css end

  // write content into css file
  $css_path = drupal_get_path('module', 'tei_imageviewer') . "/css/tei_imageviewer.css";
  file_put_contents($css_path, $css);
}




/**
 * Validate annotation settings submission.
 */
function tei_imageviewer_admin_settings_validate($form, &$form_state) {
  $limit = $form_state['values']['tei_imageviewer_limit_per_node'];
  if (!is_numeric($limit)) {
    form_set_error('tei_imageviewer_limit_per_node', t('Please enter number.'));
  }
}







