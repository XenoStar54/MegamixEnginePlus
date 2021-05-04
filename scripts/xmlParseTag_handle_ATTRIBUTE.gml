/// xmlParseTag_handle_ATTRIBUTE

var attrName = peggml_parse_elt_get_child_value(0)
var attrValue = peggml_parse_elt_get_child_value(1)
global._xmlParseTagMap[? attrName] = attrValue
