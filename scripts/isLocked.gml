/// isLocked(ids[...])
/// returns true if any of the given lock pools are locked
/// (if using instance-specific locks, call this from a particular instance.)

var _id = id

for (var i = 0; i < argument_count; ++i)
{
    var pool = argument[i]
    with (objLock)
    {
        if (targetInstance >= 0 && _id != targetInstance)
        {
            // this is an instance-specific lock which doesn't concern us.
            continue
        }
        if (arrayContains(type, pool))
        {
            return true
        }
    }
}

return false;
