/// playerIsLocked(playerLockValueType...)
// shortcut to check player global and local lock pool for the given objMegaman.
// has special understanding of PL_LOCK_GROUND and PL_LOCK_AERIAL
// values are PL_LOCK_MOVE, etc.

assert(object_index == objMegaman, "playerIsLocked can only be called from an instance of objMegaman");

for (var i = 0; i < argument_count; i++)
{
    var poolType = argument[i]
    if (isLocked(poolType)) return true
    
    if (poolType == PL_LOCK_GROUND || poolType == PL_LOCK_AERIAL)
    {
        if isLocked(PL_LOCK_MOVE)
        {
            return true
        }
    }
}

return false;
