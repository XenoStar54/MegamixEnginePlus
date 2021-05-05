/// lockPoolRelease([lock IDs...], checkedOutLock)
// releases the given lock on all lock pools.
// if lock id is non-positive, exits immediately
// If a list of lock IDs is provided, the lookup is strict
// and will throw an error if the lock set provided doesn't match what pools are actually locked.
// otherwise, error checking still occurs but only is caught if releasing the lock changes no values.

assert(argument_count > 0, "lockPoolRelease() called with no arguments")
var lock = argument[argument_count - 1];
if (lock <= 0) exit

if (instance_exists(lock))
{
    with (lock)
    {
        // ensure arguments are a subset of the `type` array
        for (var i = 0; i < argument_count - 1; ++i)
        {
            if (!arrayContains(type, argument[i]))
            {
                assert(false, "lock pool released but did not match type, id:" + string(lock))
            }
        }
        // TODO -- ensure `type` array is a subset of the arguments (this yields equality)
        instance_destroy()
    }
}
else
{
    printErr("warning: lock unlocked multiple times! id: " + string(lock))
}

return 0
