/// globalLockReset
/// deletes all lock pools, except those marked specifically as noGlobalReset

with (objLock)
{
    if (!noGlobalReset)
    {
        lockPoolRelease(id)
    }
}
