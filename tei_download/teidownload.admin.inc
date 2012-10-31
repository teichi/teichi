<?php
/**
 * @file
 * create forms.
 */
 
/**
 * form to configure the Block-Texts
 */
function teidownload_block_settings_form($form, &$form_state) {
 $form = array();
  /************* display_settings ****************/
 //$form['display_setting'] = array(
   // '#type' => 'fieldset',
    //'#title' => t('Block texts'),
    //'#collapsible' => FALSE,
    //'#collapsed' => FALSE,
    //'#weight' => 3
  //);
  
   /************* Advanced download link ****************/
  $form['display_setting']['advanced_download_link'] = array(
    '#type' => 'fieldset',
    '#title' => t('Advanced download link'),
    '#collapsible' => TRUE,
    '#collapsed' => TRUE,
  );
  
  $form['display_setting']['advanced_download_link']['teidownload_advanced_download_link'] = array(
    '#type' => 'textfield',
    '#title' => t('Label'),
    '#description' => t('Text for the advanced download link'),
    '#default_value' => variable_get('teidownload_advanced_download_link', 'Advanced download'),
    '#size' => 30,
  );
  
  
  /************* file format ****************/
  $form['display_setting']['file_format'] = array(
    '#type' => 'fieldset',
    '#title' => t('File format'),
    '#collapsible' => TRUE,
    '#collapsed' => TRUE,
  );
  
  $form['display_setting']['file_format']['teidownload_file_format'] = array(
    '#type' => 'textfield',
    '#title' => t('Label'),
    '#description' => t('Text for the file format label'),
    '#default_value' => variable_get('teidownload_file_format', 'File format'),
    '#size' => 30,
  );
  
  $form['display_setting']['file_format']['teidownload_epub_option'] = array(
    '#type' => 'textfield',
    '#title' => t('epub Option'),
    '#description' => t('Text for the epub option'),
    '#default_value' => variable_get('teidownload_epub_option', 'epub'),
    '#size' => 30,
  );
  
   $form['display_setting']['file_format']['teidownload_txt_option'] = array(
    '#type' => 'textfield',
    '#title' => t('Plain text'),
    '#description' => t('Text for the plain text option'),
    '#default_value' => variable_get('teidownload_txt_option', 'txt'),
    '#size' => 30,
  );
  
  $form['display_setting']['file_format']['teidownload_xml_option'] = array(
    '#type' => 'textfield',
    '#title' => t('TEI/XML Document'),
    '#description' => t('Text for the TEI/XML option'),
    '#default_value' => variable_get('teidownload_xml_option', 'xml'),
    '#size' => 30,
  );
  
  /************* text_variant ****************/
  $form['display_setting']['text_variant'] = array(
    '#type' => 'fieldset',
    '#title' => t('Text variant'),
    '#collapsible' => TRUE,
    '#collapsed' => TRUE,
  );
  
   $form['display_setting']['text_variant']['teidownload_text_variant'] = array(
    '#type' => 'textfield',
    '#title' => t('label'),
    '#description' => t('Text for the "text variant" lable'),
    '#default_value' => variable_get('teidownload_text_variant', 'Text variant'),
    '#size' => 30,
  );
  
   $form['display_setting']['text_variant']['teidownload_corr_reg_option'] = array(
    '#type' => 'textfield',
    '#title' => t('corr/reg Option'),
    '#description' => t('Text for the corr/reg option'),
    '#default_value' => variable_get('teidownload_corr_reg_option', 'Regularized'),
    '#size' => 30,
  );
  
  $form['display_setting']['text_variant']['teidownload_sic_orig_option'] = array(
    '#type' => 'textfield',
    '#title' => t('sic/orig Option'),
    '#description' => t('Text for the sic/orig option'),
    '#default_value' => variable_get('teidownload_sic_orig_option', 'Original'),
    //'#default_value' => variable_get('teidownload_sic_orig_option', 'Transcription linéaire'),
    '#size' => 30,
  );
  
  /************* notes ****************/
  $form['display_setting']['notes'] = array(
    '#type' => 'fieldset',
    '#title' => t('Notes'),
    '#collapsible' => TRUE,
    '#collapsed' => TRUE,
  );
  
   $form['display_setting']['notes']['teidownload_notes'] = array(
    '#type' => 'textfield',
    '#title' => t('Lable'),
    '#description' => t('Text for the Notes label'),
    '#default_value' => variable_get('teidownload_notes', 'Notes'),
    '#size' => 30,
  );
  
   $form['display_setting']['notes']['teidownload_author_option'] = array(
    '#type' => 'textfield',
    '#title' => t('Author Option'),
    '#description' => t('Text for the Author option'),
    '#default_value' => variable_get('teidownload_author_option', 'Author'),
    '#size' => 30,
  );
  
  $form['display_setting']['notes']['teidownload_author_editor_option'] = array(
    '#type' => 'textfield',
    '#title' => t('Editor Option'),
    '#description' => t('Text for the "author & editor" option'),
    '#default_value' => variable_get('teidownload_author_editor_option', 'Author & Editor'),
    '#size' => 30,
  );
   
  /************* chapters ****************/
  $form['display_setting']['chapters'] = array(
    '#type' => 'fieldset',
    '#title' => t('Chapters'),
    '#collapsible' => TRUE,
    '#collapsed' => TRUE,
  );
  
  $form['display_setting']['chapters']['teidownload_chapters'] = array(
    '#type' => 'textfield',
    '#title' => t('label'),
    '#description' => t('Text for the chapters lable'),
    '#default_value' => variable_get('teidownload_chapters', 'Chapters'),
    '#size' => 30,
  );
  
  /************* download_form ****************/
  $form['display_setting']['download_form'] = array(
    '#type' => 'fieldset',
    '#title' => t('Download form'),
    '#collapsible' => TRUE,
    '#collapsed' => TRUE,
  );
  
  $form['display_setting']['download_form']['teidownload_download_form'] = array(
    '#type' => 'textfield',
    '#title' => t('Download form'),
    '#description' => t('Text for the "download form" lable'),
    '#default_value' => variable_get('teidownload_download_form', 'Download form'),
    '#size' => 30,
  );
  
  $form['display_setting']['download_form']['teidownload_single_option'] = array(
    '#type' => 'textfield',
    '#title' => t('Single file for all chapters'),
    '#description' => t('Text for the "Single file for all chapters" option'),
    '#default_value' => variable_get('teidownload_single_option', 'Single file for all chapters'),
    '#size' => 30,
  );
  
   $form['display_setting']['download_form']['teidownload_separate_option'] = array(
    '#type' => 'textfield',
    '#title' => t('Separate chapter files'),
    '#description' => t('Text for the "Separate chapter files" option'),
    '#default_value' => variable_get('teidownload_separate_option', 'Separate chapter files'),
    '#size' => 30,
  );
  
   /************* download_button ****************/
  $form['display_setting']['download_button'] = array(
    '#type' => 'fieldset',
    '#title' => t('Download button'),
    '#collapsible' => TRUE,
    '#collapsed' => TRUE,
  );
  
  $form['display_setting']['download_button']['teidownload_download_button'] = array(
    '#type' => 'textfield',
    '#title' => t('Lable'),
    '#description' => t('Text for the download button'),
    '#default_value' => variable_get('teidownload_download_button', 'Download'),
    '#size' => 30,
  );
  
  //$form['#submit'][] = '_teidownload_settings_form_submit';
  return system_settings_form($form);
}

/**
 * book settings form to configure file format, first page and second page of the e-book
 */
function teidownload_book_settings_form($form, &$form_state) {
 $bid = arg(6);
 /************* download_setting ****************/
  $form['file_format'] = array(
    '#type' => 'fieldset',
    '#title' => t('File formats'),
    '#collapsible' => FALSE,
    '#collapsed' => FALSE,
  );
  
  $form['file_format']['teidownload_download_setting_' . $bid] = array(
    '#title' => '',
    '#type' => 'checkboxes',
    '#description' => t('Choose the file formats that can be downloaded.'),
    '#default_value' => variable_get('teidownload_download_setting_' . $bid, array('epub' => 'epub', 'txt' => 'txt',   'xml' => 'xml')),
    '#options'  => array('epub' => t('EPUB'), 'txt' => t('Plain text'), 'xml' => t('TEI/XML')),
    '#required' => TRUE,
  );
  
  /************* Cover image ****************/
   $form['cover'] = array(
    '#type' => 'fieldset',
    '#title' => t('Cover image (.epub only)'),
    '#collapsible' => FALSE,
    '#collapsed' => FALSE,
  );
  $form['cover']['teidownload_first_page_' . $bid] = array(
    '#type' => 'checkboxes',
    '#description' => t('Check this option to add the cover image to the first page of the E-Book.'),
    '#default_value' => variable_get('teidownload_first_page_' . $bid, array()),
    '#options'  => array('cover' => t('Enable')),
  );
  
  /************* Metadata ****************/
  $form['metadata'] = array(
    '#type' => 'fieldset',
    '#title' => t('E-Book Metadata (.epub only; from /TEI/teiHeader/...)'),
    '#collapsible' => FALSE,
    '#collapsed' => FALSE,
  );
  
  $form['metadata']['teidownload_second_page_' . $bid] = array(
    '#type' => 'checkboxes',
    '#description' => t('Choose which information should be shown on the second page of the E-Book.'),
    '#default_value' => variable_get('teidownload_second_page_' . $bid, array()),
    '#options'  => array(
      'title' => t('Title (.../fileDesc/titleStmt/title)'),
      'author' => t('Author (.../fileDesc/titleStmt/author)'),
      'editor' => t('Editor (.../fileDesc/titleStmt/editor)'),
      'edition' => t('Edition (.../fileDesc/editionStmt/edition)'),
      'publicationStmt' => t('Publication statement (.../fileDesc/publicationStmt)'),
      'projectDesc' => t('Project description (.../encodingDesc/projectDesc)'),
      'file_version' => t('File version information (see below)'),
    )
  );
  /************* Designation of editor ****************/
  $form['designation_of_editor'] = array(
    '#type' => 'fieldset',
    '#title' => t('Designation of editor'),
    '#collapsible' => FALSE,
    '#collapsed' => FALSE,
  );
  
  $form['designation_of_editor']['teidownload_designation_of_editor_' . $bid] = array(
    '#type' => 'textfield',
    '#description' => t('Text designating the editor on the title page.'),
    '#default_value' => variable_get('teidownload_designation_of_editor_' . $bid, 'Edited by'),
    '#size' => 25,
   );
   
  $form['file_version'] = array(
    '#type' => 'fieldset',
    '#title' => t('Text for file version information'),
    '#collapsible' => FALSE,
    '#collapsed' => FALSE,
  );
  
  $form['file_version']['teidownload_text_for_corr_reg_' . $bid] = array(
    '#type' => 'textfield',
    '#title' => 'Text for corr/reg version',
    '#default_value' => variable_get('teidownload_text_for_corr_reg_' . $bid, 'This file contains a modernized version of the text.'),
    '#size' => 65,
   );
   
   $form['file_version']['teidownload_text_for_sic_orig_' . $bid] = array(
    '#type' => 'textfield',
    '#title' => 'Text for sic/orig version',
    '#default_value' => variable_get('teidownload_text_for_sic_orig_' . $bid, 'This file contains a linear transcription of the text.'),
    '#size' => 65,
   );
    
   $form['file_version']['teidownload_text_for_author_notes_' . $bid] = array(
    '#type' => 'textfield',
    '#title' => 'Text for "author notes" version',
    '#default_value' => variable_get('teidownload_text_for_author_notes_' . $bid, "It includes only the author's notes."),
    '#size' => 65,
   );
   
   $form['file_version']['teidownload_text_for_author_editor_notes_' . $bid] = array(
    '#type' => 'textfield',
    '#title' => 'Text for "author & editor notes" version',
    '#default_value' => variable_get('teidownload_text_for_author_editor_notes_' . $bid, "It includes the author's as well as the editor's notes."),
    '#size' => 65,
   );
 return system_settings_form($form);
}

/**
 * cover upload form
 */
function teidownload_book_cover_upload_form($form, &$form_state) {
  $form['cover_setting'] = array(
    '#type' => 'fieldset',
    '#title' => t('Cover'),
    '#collapsible' => TRUE,
    '#collapsed' => FALSE,
  );
  
  $bid = arg(6);
  $result = db_query("SELECT image_path FROM {teidownload_books} t WHERE t.bid = :bid", array(':bid' => $bid));
  $record = $result->fetch();
  if (!empty($record)) {
    $image_path = $record->image_path;
    $variables = array(
    'path' => $image_path, 
    'title' => 'Cover',
    'width' => '30%',
    'height' => '30%',
    //'attributes' => array('class' => 'some-img', 'id' => 'my-img'),
    );
    // Form to save the path of the image, this can be used to delete the image without to use the sql
    // query to get the path for a book
    $form['cover_setting']['teidownload_image_path'] = array('#type' => 'value', '#value' => $image_path);
    $form['cover_setting']['teidownload_image'] = array(
      '#markup' => theme('image', $variables),
    );
    
    $form['cover_setting']['teidownload_image_delete'] = array(
      '#type' => 'checkbox', 
      '#title' => t('Delete image'), 
      '#description' => t('Check this box to delete your current image.')
    );
  }
    
  $form['cover_setting']['teidownload_image_upload'] = array(
    '#type' => 'file', 
    '#title' => t('Upload image'), 
    '#size' => 30, 
    '#description' => t('Maximum dimensions are %dimensions', 
    array('%dimensions' => '600x800')),
  );
  
  $form['cover_setting']['teidownload_submit_upload'] = array(
    '#type' => 'submit',
    '#value' => 'Submit'
  );
  return $form;
}

/**
 * cover upload submit
 */
function teidownload_book_cover_upload_form_submit($form, &$form_state) {
  $bid = arg(6);
  // Delete image if requested, and if no replacement image was given.
  if (!empty($form_state['values']['teidownload_image_delete']) && $form_state['values']['teidownload_image_upload'] =='') {
    // Delete image from webspace
    $image_path = $form_state['values']['teidownload_image_path'];
    if (file_exists($image_path)) {
      unlink($image_path);
    }
    // Delete image from Database
    $num_deleted = db_delete('teidownload_books')
      ->condition('bid', $bid)
      ->execute();
  }    
  else { // Save the new image and delete the old one if exist
    // Create directory if not exist 
    $dir_path = 'public://teidownload/';
    file_prepare_directory($dir_path, FILE_CREATE_DIRECTORY);
    // Validator only JPEG,PNG,GIF are allowed
    $validators = array(
    'file_validate_is_image' => array(),
    //'file_validate_image_resolution' => array('600x800'),
    );
    // upload temporary
    if ($file = file_save_upload('teidownload_image_upload', $validators)) {
      // Delete the Old imgae from the webspace when exist
      if (isset($form_state['values']['teidownload_image_path'])) {
        $image_path = $form_state['values']['teidownload_image_path'];
        if (file_exists($image_path)) {
          unlink($image_path);
        }
      }
      // save the new image in the database
      $destination = $dir_path . 'book_' . $bid . '_' . $file->filename;
      // copy temp file to the TEI2Pub directory
      if ($file = file_copy($file, $destination, FILE_EXISTS_REPLACE)) {
         db_merge('teidownload_books')
        ->key(array('bid' => $bid))
        ->fields(array('image_path' => $destination))
        ->execute();
        // change status and save the file again into file_managed table
        $file->status |= FILE_STATUS_PERMANENT;
        file_save($file);
         drupal_set_message(t('Upload successfully'));     
      } 
      else {
         form_set_error('image_upload', t("Failed to upload the image; the %directory directory doesn't exist or is not writable.", $dir_path));
      }
    }
  }
}
