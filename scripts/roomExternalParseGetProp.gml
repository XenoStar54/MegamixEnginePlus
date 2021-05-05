/// roomExternalParseGetProp(property:string, [default])

var prop = argument[0]
var _default = global._undefined
if (argument_count > 1)
{
    _default = argument[1]
}

var value = global._roomExternalRoomProps[? prop]
if (is_undefined(value)) return _default;
return value