<?php
/**
 * @file
 * include file for TEIChi module
 * contains functions for css file creation
 */

function _teicontent_write_css_file() {

  $note_color = variable_get('teichicontent_note_color', '#e3e9f0');
  $sic_corr_highlight_color = variable_get('teichicontent_sic_corr_highlight_color', '#eff682');
  $orig_reg_highlight_color = variable_get('teichicontent_orig_reg_highlight_color', '#e6e7fd');
  $menubar_color = variable_get('teichicontent_menubar_color', '#c3c8f2');

  $main_text_width = variable_get('teichicontent_maintext_width', '73%');
  $notes_width = variable_get('teichicontent_notes_width', '33%');
  $menu_width = variable_get('teichicontent_menu_width', '100%');


  $teichi_maintext_font = variable_get('teicontent_maintext_font', TEICONTENT_DEFAULT_FONT);
  $teichi_notes_font = variable_get('teicontent_notes_font', TEICONTENT_DEFAULT_FONT);
  $teichi_menu_font = variable_get('teicontent_menu_font', TEICONTENT_DEFAULT_FONT);

  // font-face difinition if needed
  $teichi_maintext_font_def = "";
  $teichi_notes_font_def = "";
  $teichi_menu_font_def = "";

  $font_dir = drupal_realpath(TEICONTENT_FONT_DIR);
  $font_url_path = parse_url($font_dir);
  $font_dir = $font_url_path['path'];
  if ($teichi_maintext_font !== "Sans-Serif"
      && $teichi_maintext_font !== "Serif"
      && $teichi_maintext_font !== "Monospace") {
    $teichi_maintext_font_family = "\"" . _teicontent_font_extension($teichi_maintext_font, FALSE) . "\"";
    $teichi_maintext_font_def = "@font-face{"
      . "\nfont-family:" . $teichi_maintext_font_family . ";"
      . "\nsrc: url(" . $font_dir . "/" . $teichi_maintext_font . ") format(\"" . (_teicontent_font_format($teichi_maintext_font)) . "\")" . "\n}\n";
  }
  else {
    $teichi_maintext_font_family = $teichi_maintext_font;
  }

  if ($teichi_notes_font !== "Sans-Serif"
      && $teichi_notes_font !== "Serif"
      && $teichi_notes_font !== "Monospace"
      && $teichi_notes_font !== $teichi_maintext_font) {
    $teichi_notes_font_family = "\"" . _teicontent_font_extension($teichi_notes_font, FALSE) . "\"";
    $teichi_notes_font_def = "@font-face{"
      . "\nfont-family:" . $teichi_notes_font_family . ";"
      . "\nsrc: url(" . $font_dir . "/" . $teichi_notes_font . ") format(\"" . (_teicontent_font_format($teichi_notes_font)) . "\")" . "\n}\n";
  }
  else {
    $teichi_notes_font_family = $teichi_notes_font;
  }

  if ($teichi_menu_font !== "Sans-Serif"
      && $teichi_menu_font !== "Serif"
      && $teichi_menu_font !== "Monospace"
      && $teichi_menu_font !== $teichi_maintext_font
      && $teichi_menu_font !== $teichi_notes_font) {
    $teichi_menu_font_family = "\"" . _teicontent_font_extension($teichi_menu_font, FALSE) . "\"";
    $teichi_menu_font_def = "@font-face{"
      . "\nfont-family:" . $teichi_menu_font_family . ";"
      . "\nsrc: url(" . $font_dir . "/" . $teichi_menu_font . ") format(\"" . (_teicontent_font_format($teichi_menu_font)) . "\")"
      . "\n}\n";
  }
  else {
    $teichi_menu_font_family = $teichi_menu_font;
  }


  $css=<<<CSS
{$teichi_maintext_font_def}
{$teichi_notes_font_def}
{$teichi_menu_font_def}

/* ##### Drupal-Main container ##### */
#inner-content,#center {
  font-family:{$teichi_maintext_font_family},serif;
}

.maincontent {
  font-family:{$teichi_maintext_font_family},
  serif;
}

.maincontent {
  font-size:16px;
  margin-left:0%;
  width:{$main_text_width};
  text-align:justify;
  line-height: 1.8;
}

/* ##### Links ##### */
/*
a {
  color:#3362a3;
  text-decoration:none;
}

a:hover {
 text-decoration:underline;
}

.pagelink {
  font-weight:bold;
  color:#182e6d;
}
*/

.extlink{color:#444;}

.note {
  position:relative;
  float:right;
  clear:none;
  font-family:{$teichi_notes_font_family};
  width:{$notes_width};
  background-color:{$note_color};
  z-index:1;
  display:inline;
  max-height:250px;
  overflow:hidden;
  margin-right:-40%;
  text-align:left;
  display:block;
  line-height:1;
}

.note a {
  display:inline;
  text-decoration:none;
  font-weight:bold;
}

.note span.content {
  line-height:2;
  display:none;
  font-size:0.80em;
}

/*
.note:hover{
  z-index:10;
}

.note:hover span.content {
  color:black;
  background:#ffffff;
  display:block;
  padding:10px;
}
*/

/* ##### Links to notes #####  */
.authornotelink, .editornotelink {
  color:white;
  background-color:#2e4a6b;
  cursor:pointer;
}

/* ##### Notes: author ##### */
.author {
  margin-top:-1px;
}

/* ##### Notes: editor ##### */
.editor {
  margin-top:20px;
}

/* ##### Textual variants via choice ##### */
.sic, .corr{
  background-color:{$sic_corr_highlight_color};
}

.orig, .reg, .abbr, .expan {
  background-color:{$orig_reg_highlight_color};
}


/* ##### Standard display reg-corr-expan etc. ##### */
.orig{ display:none;}
.sic{display:none;}
.hi{font-style: italic;}
.emph{font-style: italic;}
.mentioned{font-style: normal;}
.ll{font-size:0.85em;}
.note .ll{margin-left:0%;font-size:1.1em;}
.block{font-size:15px;}
.italic{font-style: italic;}
.verse{font-size:1.0em;}
.verse .note .content{font-size:0.85em;}
.epigraph {margin-left: 40%; font-size:0.90em;}
.trailer{text-align:center; font-variant:small-caps;}
.dateline{margin-left: 60%;}
.salute{margin-left: 5%;}
.signed{margin-left: 10%; font-style: italic; line-height: 2.2; font-size:1.0em; }
.del{text-decoration: line-through;}
.add{text-decoration: underline;}
.gap{text-decoration:none}
.unclear{background-color: #FFB3B3;}
.stage{font-style:italic; font-variant:normal}
.speaker{font-variant:small-caps;}
.sp{font-size:inherit;}
.lb{text-decoration:none;}


/* ##### Toolbar at the bottom of the page ##### */
#teichisubmenucontainer {
  margin:0px;
  position:fixed;
  left:0px;
  bottom:0px;
  width:100%;
  text-align:center;
}

#submenu {
  width:{$menu_width};
  margin:auto;
  background-color:{$menubar_color};
  z-index:23;
  font-size:1.1em;
  text-align:center;
  border-top-left-radius: 3px;
  border-top-right-radius: 3px;
}

/*#submenu a{color:white;text-decoration:none;}*/

#submenu input {
  font-size:0.85em;
  padding:1px;
}

#pageindex {
  display:none;
  overflow:auto;
  width:100px;
  height:300px;
  background-color:{$menubar_color};
  opacity:0.8;
  text-align:center;
  font-size:13px;
  border:1px solid;
  border-top-color:#ccc;
  border-left-color:#ccc;
  border-bottom-color:#666;
  border-right-color:#666;
}

#pageindex,#submenu {
 font-family:{$teichi_menu_font_family};
}

a.pageindexlink ,#pageindex a {
  font-weight:bold;
  text-decoration:none;
  color:black;
}

#pageindex li {
  text-align:left;
  line-height:1.5;
}


#nt {
  font-size:0.9em;
  width:200px;
  max-height:200px;
  overflow:auto;
  position:absolute;
  right:20px;
  background-color:#eee;
  border:1px solid;
  border-top-color:#ccc;
  border-left-color:#ccc;
  border-bottom-color:#666;
  border-right-color:#666;
}

#activetextmode {
  color:#6a95c6;
}

#passivetextmode {
  color:#ffffff;
}

#pagesearch{
  display:inline;
}

#pnr,#pnrsubmit {
  font-size:11px;
  border:1px solid #345667;
}

.teichi-form-separator {
 height:210px;
 border:none;
}
CSS;

  // write content into css file
  $css_path = drupal_get_path('module', 'teicontent') . "/css/teichi.css";
  file_put_contents($css_path, $css);
}