
/**
 * Validates the sent XML according to the specified validation type.
 * @param xml
 *   The XML content to be validated as a string
 * @param validation
 *   The validation type required (string): possible values are (none, wellformed,dtd,xsd,rng)
 * @param schema_path
 *   The path to the schema file
 */
function _teicontent_validate($xml, $validation = 'wellformed', $schema_path = null) {

  if (!$xml) {
    return false;
  }

  $xml_val = $xml[LANGUAGE_NONE][0]['value'];

  $dom = new DomDocument('1.0', 'UTF-8');
  switch ($validation) {
    case 'none':
      $ok = true;
      break;
    
    case 'wellformed':
      $ok = $dom->loadXML($xml_val);
      break;
    
    case 'dtd':
      if ($ok = $dom->loadXML($xml_val)) {
        $ok = $dom->validate();
      }
      break;
      
    case 'xsd':
      if ($ok = $dom->loadXML($xml_val)) {
        $ok = $dom->schemaValidate($schema_path);
      }
      break;

    case 'rng':
      if ($ok = $dom->loadXML($xml_val)) {
        $ok = $dom->relaxNGValidate($schema_path);
      }
      break;
  }
  return $ok;
}