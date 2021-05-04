if (argument_count > 0)
{
    global.xmlParseTagWithPeg = argument0
}
else
{
    global.xmlParseTagWithPeg = true
}
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
peggml_parser_set_handler(global._xmlTagParser, "TAG", scrNoEffect)

// test
var tag2 = xmlParseTag('<test/>')
assert(tag2 >= 0, "xmlParseTag failed: " + global.xmlParseTagError)
assert(global.xmlParseTagError == "", "xmlParseTag failed: " + global.xmlParseTagError)
var tag = xmlParseTag('<test a="4" b="asd"/>')
assert(tag >= 0, "xmlParseTag failed: " + global.xmlParseTagError)
assert(global.xmlParseTagError == "", "xmlParseTag failed: " + global.xmlParseTagError)
assert(tag[? "a"] == "4", "xmlParseTag failed")
assert(tag[? "b"] == "asd", "xmlParseTag failed")
ds_map_destroy(tag)/// xmlParseTagInit