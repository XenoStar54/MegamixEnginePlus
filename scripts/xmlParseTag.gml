<<<<<<< HEAD
/// xmlParseTag(tag)
/// parses a tag of the form <tagname attribute="value" attr2="val2">
/// into a map from attribute to value.
/// do not forget to free the map after you use it!

if (global.xmlParseTagWithPeg)
{
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
}
else
{
    var dsm, tag = stringTrim(argument0);
    dsm = ds_map_create();
    // seek to end of tag
    tag = stringSubstring(tag, string_pos(" ", tag) + 1);
    while (tag!=">")
    {
        var attr, value;
        
        // read attribute
        var eqPos = string_pos("=", tag);
        attr = stringSubstring(tag, 1, eqPos);
        tag = stringSubstring(tag, eqPos + 1);
        
        // read value
        var q1Pos = string_pos('"', tag)
        tag = stringSubstring(tag, q1Pos + 1);
        var q2Pos = string_pos('"', tag)
        value = stringSubstring(tag, 1, q2Pos);
        tag = stringSubstring(tag, q2Pos + 2);
        
        dsm[? attr] = value;
    }
    
    return dsm;
}
||||||| 1fce796d
/// xmlParseTag(tag)
/// parses a tag of the form <tagname attribute="value" attr2="val2">
/// into a map from attribute to value.
/// do not forget to free the map after you use it!

if (global.xmlParseTagWithPeg)
{
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
}
else
{
    var dsm, tag = stringTrim(argument0);
    dsm = ds_map_create();
    // seek to end of tag
    tag = stringSubstring(tag, string_pos(" ", tag) + 1);
    while (tag!=">")
    {
        var attr, value;
        
        // read attribute
        var eqPos = string_pos("=", tag);
        attr = stringSubstring(tag, 1, eqPos);
        tag = stringSubstring(tag, eqPos + 1);
        
        // read value
        var q1Pos = string_pos('"', tag)
        tag = stringSubstring(tag, q1Pos + 1);
        var q2Pos = string_pos('"', tag)
        value = stringSubstring(tag, 1, q2Pos);
        tag = stringSubstring(tag, q2Pos + 2);
        
        dsm[? attr] = value;
    }
    
    return dsm;
}

#define xmlParseTagInit
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
=======
>>>>>>> peggml-b
