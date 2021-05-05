#define __lf_
// https://bugs.yoyogames.com/view.php?id=29984
#define __lf_roomExternalInit_roomExternalParseLines
/// __lf_roomExternalInit_roomExternalParseLines(v0)
//!#lambda roomExternalParseLines
 {
/// roomExternalParseLine(lines:string)
var lines = stringSplit(argument0, global.newLine)
for (var i = 0; i < array_length_1d(lines); ++i)
{
    roomExternalParseLine(lines[i])
}
}
#define __lf_roomExternalInit__roomExternalInit_handle_tag
/// __lf_roomExternalInit__roomExternalInit_handle_tag(v0)
//!#lambda  _roomExternalInit_handle_tag
 {
///_roomExternalInit_handle_tag(list)
var str = peggml_parse_elt_get_string()
if (is_string(str))
{
    ds_list_add(argument0, str)
}
return 0
}
#define __lf_roomExternalInit__roomExternalInit_handle_value
/// __lf_roomExternalInit__roomExternalInit_handle_value(v0)
//!#lambda _roomExternalInit_handle_value
 {
///_roomExternalInit_handle_value(name)
var value = peggml_parse_elt_get_child_value()
global._roomExternalRoomProps[? argument0] = value
return value
}
#define __lf_roomExternalInit__roomExternalInit_handle_NUMBER
/// __lf_roomExternalInit__roomExternalInit_handle_NUMBER()
//!#lambda _roomExternalInit_handle_NUMBER
 {
return peggml_parse_elt_get_token_number()
}
#define __lf_roomExternalInit__roomExternalInit_handle_TEXT
/// __lf_roomExternalInit__roomExternalInit_handle_TEXT()
//!#lambda _roomExternalInit_handle_TEXT
 {
return peggml_parse_elt_get_string()
}
#define __lf_roomExternalInit__roomExternalInit_handle_CODE_BEGIN
/// __lf_roomExternalInit__roomExternalInit_handle_CODE_BEGIN()
//!#lambda _roomExternalInit_handle_CODE_BEGIN
 {
global._roomExternalLatchCC = true
global._roomExternalCCAccumulate = ""
}