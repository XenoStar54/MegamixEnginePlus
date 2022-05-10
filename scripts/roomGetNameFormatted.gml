/// roomGetNameFormatted(room)
var _str = room_get_name(argument0);

// remove prefix
if (string_copy(_str, 1, 3) == "lvl")
{
    _str = string_copy(_str, 4, string_length(_str));
}
else if (string_copy(_str, 1, 2) == "rm")
{
    _str = string_copy(_str, 3, string_length(_str));
}

// add spaces before each uppercase letter
for (var _i = 2; _i <= string_length(_str); _i++)
{
    var _ns = string_copy(_str, _i + 1, 1);
    var _s = string_copy(_str, _i, 1);
    var _ls = string_copy(_str, _i - 1, 1);
    
    if ((ord(_s) >= ord("A") && ord(_s) <= ord("Z") // before capital letters
            && (ord(_ls) < ord("A") || ord(_ls) > ord("Z"))) // make sure not part of an acronym
        || (_i <= string_length(_str) - 1 && (ord(_ns) < ord("A") || ord(_ns) > ord("Z")) // end of an acronym
            && ord(_s) >= ord("A") && ord(_s) <= ord("Z")
            && ord(_ls) >= ord("A") && ord(_ls) <= ord("Z"))
        || ((ord(_s) >= ord("0") && ord(_s) <= ord("9")) // start / end of a number
            ^^ (ord(_ls) >= ord("0") && ord(_ls) <= ord("9")))
        && _ls != " ") // There's already a space
    {
        _str = string_copy(_str, 1, _i - 1) + " " + string_copy(_str, _i, string_length(_str));
        _i++; // skip the space we just added
    }
}

return _str;
