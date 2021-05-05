/// lockPoolLock(ids...)
// creates and initializes an objLock object locking the provided pools

gml_pragma("global", "global._objLockInitContext = false")
assert(object_index != objLock, "cannot lock from within lock instance. (What are you doing..?)")

// we record x and y positions for debugging purposes, to figure out literally where the lock was created
global._objLockInitContext = true
var lock = instance_create(x, y, objLock)
global._objLockInitContext = false
assert(instance_exists(lock))

// set lock type
for (var i = 0; i < argument_count; ++i)
{
    lock.type[i] = argument[i]
}

// set debug info
lock.debugInfo = "-"
lock.debugInfoSourceInstance = id
lock.debugInfoSourceObject = object_index
lock.debugInfoSourceRoom = room
if (!global.ogmIsHost)
{
    lock.debugInfoEventNumber = event_number
    lock.debugInfoEventObject = event_object
    lock.debugInfoEventType = event_type
}
lock.debugInfoTime = get_timer()

return lock
