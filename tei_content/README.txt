= TEI Content module =

== Description == 

The TEI Content module allows the display of textual documents encoded according to the standards of the Text Encoding Initiative (TEI). Texts are stored in the Drupal native database and displayed through an XSL transformation using the content filter mechanism. The module provides specific support for many of the features that are part of the TEI Lite (P5) set of elements.

== Possible use cases == 

Possible use cases for TEI Content and the TEICHI Framework generally are text edition projects in literary studies, history, or other text-based disciplines, provided they have a relatively straightforward editorial situation: only one given edition of a text is documented, a single-column presentation makes sense, and authorial and editorial annotation are important. The modules could also be of use in educational contexts, e.g. workshops on electronic textual editing.

== Requirements and compatibility == 

TEI Content relies on XSLT, CSS and JavaScript. Text encoding needs to be done in TEI Lite (P5). MySQL 5.0.15 or higher including libxslt is required. TEI Content does not rely on any other contributed modules, but the Drupal core book module needs to be enabled.

The modules are tested with and work for Firefox (currently 3.6), Chrome (currently 8.0), and Internet Explorer (currently 8). The modules are currently known to be compatible with Drupal’s Garland and Bartik themes.

== Installation == 

The installation follows the standard procedure for modules in Drupal 7. Please consult the relevant Drupal documentation (http://drupal.org/documentation/install/modules-themes).

Once the TEI Content module has been activated, an entry appears towards the bottom of the list of modules in the “Module” section of the Administration menu. The appropriate entry will then show a “Preferences” link.

When the module is activated, a new content type is automatically created. It is called “teichi” and its settings can be modified in the “Configuration” > “Text formats” section of the Administration page. There, click on “configure” in the “teichi” entry and activate the text format for all three roles of users (anonymous, authenticated, administrator). You should also activate the text format for those of Drupal’s menus that you may wish to use.

== Documentation == 

More detailed documentation on the customization and use of this module and of the other modules in the TEICHI framework comes bundled with the module. Look for a PDF file called "TEICHI-Documentation" in the module folder. The documentation also helps with encoding documents in TEI Lite and with customizing the stylesheet.

== Credits == 

Current maintainer: Christof Schöch (christof.s) - http://drupal.org/user/1152238
Coders: Roman Kominek, with Dmitrij Funkner, Mohammed Abuhaish, Stefan Achler.
Project supervisors: Christof Schöch, Lutz Wegner and Sebastian Pape, University of Kassel, Germany.
This module is partly inspired from the XML Content module (http://drupal.org/project/xmlcontent).

== Version == 

7.x-0.8


(This document was last updated on May 22, 2011.)