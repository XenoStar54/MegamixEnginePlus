/// roomExternalParseLine(line:string)
var line = argument0

if (!global._roomExternalLatchCC)
{
    peggml_parse(global.roomExternalParser, line)
    
    if (global._roomExternalLatchCC)
    {
        global._roomExternalCCAccumulate += line + global.newLine
    }
}
else
{
    global._roomExternalCCAccumulate += line + global.newLine
    if (string_pos("</code>", line) != 0)
    {
        peggml_parse(global.roomExternalParser, global._roomExternalCCAccumulate)
        global._roomExternalLatchCC = false
        global._roomExternalCCAccumulate = ""
    }
    else
    {
        assert(string_pos("<", line) == 0, "escaped </code> while parsing <code>")
    }
}

// remap xml from string to map (for instances, backgrounds, etc...)
for (var i = 0; i < array_length_1d(global._roomExternalXMLMaps); ++i)
{
    var xlist = global._roomExternalXMLMaps[i]
    var len = ds_list_size(xlist)
    if (len > 0 && is_string(xlist[| len - 1]))
    {
        var tag = xmlParseTag(xlist[| len - 1])
        if (tag >= 0)
        {
            xlist[| len - 1] = tag
        }
    }
}

peggml_clear_error()