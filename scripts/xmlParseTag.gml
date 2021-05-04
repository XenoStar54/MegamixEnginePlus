/// xmlParseTag(tag)
/// parses a tag of the form <tagname attribute="value" attr2="val2">
/// into a map from attribute to value.
/// do not forget to free the map after you use it!

global._xmlParseTagMap = ds_map_create()

global.xmlParseTagError = ""
peggml_clear_error()
peggml_parse(global._xmlTagParser, argument0)

if (peggml_error())
{
    global.xmlParseTagError = peggml_error_str()
    peggml_clear_error()
}

return global._xmlParseTagMap;

#define xmlParseTagInit
global.xmlParseTagError = ""
global._xmlTagParser = peggml_parser_create("
TAG <- '<' ATTRNAME ATTRIBUTE* '/>'
ATTRIBUTE <- ATTRNAME '=' '" + global.doubleQuote + "' ATTRVAL '" + global.doubleQuote + "'
ATTRNAME <- < [a-zA-Z0-9]+ >
ATTRVAL <- < [^" + global.doubleQuote + "]* >
%whitespace  <-  [ \t\r\n]*
")

peggml_parser_set_handler(global._xmlTagParser, "ATTRNAME", xmlParseTag_handle_token)
peggml_parser_set_handler(global._xmlTagParser, "ATTRVAL", xmlParseTag_handle_token)
peggml_parser_set_handler(global._xmlTagParser, "ATTRIBUTE", xmlParseTag_handle_ATTRIBUTE)
peggml_parser_set_handler(global._xmlTagParser, "TAG", xmlParseTag_handle_none)

// test
var tag2 = xmlParseTag('<test/>')
assert(tag2 >= 0, "xmlParseTag failed: " + global.xmlParseTagError)
assert(global.xmlParseTagError == "", "xmlParseTag failed: " + global.xmlParseTagError)
var tag = xmlParseTag('<test a="4" b="asd"/>')
assert(tag >= 0, "xmlParseTag failed: " + global.xmlParseTagError)
assert(global.xmlParseTagError == "", "xmlParseTag failed: " + global.xmlParseTagError)
assert(tag[? "a"] == "4", "xmlParseTag failed")
assert(tag[? "b"] == "asd", "xmlParseTag failed")
ds_map_destroy(tag)

#define xmlParseTag_handle_ATTRIBUTE
var attrName = peggml_parse_elt_get_child_value(0)
var attrValue = peggml_parse_elt_get_child_value(1)
global._xmlParseTagMap[? attrName] = attrValue

#define xmlParseTag_handle_token
var value = peggml_parse_elt_get_token_string()
return value

#define xmlParseTag_handle_none
return 0