/// roomExternalParseBegin
ds_map_clear(global._roomExternalRoomProps)
// free xml tags
for (var i = 0; i < array_length_1d(global._roomExternalXMLMaps); ++i)
{
    var xlist = global._roomExternalXMLMaps[i]
    for (var j = 0; j < ds_list_size(xlist); ++j)
    {
        if (!is_string(xlist[| j])) // could be a string if some error occurred and we didn't remap string -> parsed xml map
        {
            ds_map_destroy(xlist[| j])
        }
    }
    ds_list_clear(xlist)
}
global._roomExternalLatchCC = false
global._roomExternalCCAccumulate = ""