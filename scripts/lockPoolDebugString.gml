/// lockPoolDebugString

var s = "  -- Lock Pool Info --#"

if (instance_number(objLock) == 0)
{
    s += "No locks currently active.#"
}
else
{
    with (objLock)
    {
        s += "lock id:" + string(id) + ":#"
        
        // list instance
        if (targetInstance >= 0 && instance_exists(targetInstance))
        {
            s += "  on " + object_get_name(targetInstance.object_index) + ":" + string(targetInstance) + "#"
        }
        
        // list pools
        s += "  pools: ["
        for (var i = 0; i < array_length_1d(type); ++i)
        {
            if (i != 0) s += ","
            s += string(type[i])
        }
        s += "]#"
        
        // source instance
        if (instance_exists(debugInfoSourceInstance))
        {
            s += "  creator's id: " + string(debugInfoSourceInstance) + "#"
        }
        
        if (object_exists(debugInfoSourceObject))
        {
            s += "  creator object: " + object_get_name(debugInfoSourceObject) + "#"
        }
        
        // source room
        if (room != debugInfoSourceRoom)
        {
            s += "  room: " + roomExternalGetName(debugInfoSourceRoom) + "#"
        }
        
        // event info
        var evstr = ""
        if (debugInfoEventObject >= 0 && object_exists(debugInfoEventObject))
        {
            evstr += ", " + object_get_name(debugInfoEventObject)
        }
        if (debugInfoEventNumber >= 0)
        {
            evstr += ", enum " + string(debugInfoEventNumber)
        }
        if (debugInfoEventType >= 0)
        {
            evstr += ", etype " + string(debugInfoEventType)
        }
        if (string_length(evstr) >= 2)
        {
            s += "  in: " + stringSubstring(evstr, 3) + "#"
        }
        
        // debug info
        s += "  " + debugInfo + "#"
    }
}

return string_replace_all(s, "#", global.newLine)
