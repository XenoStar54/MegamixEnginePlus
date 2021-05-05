/// playerTimeStopped()
// Locks the player's movement
// returns lock ID which should be used for playerTimeRestored()

with (objMegaman)
{
    xspeed = 0;
    yspeed = 0;
}

var lock = lockPoolLock(PL_LOCK_MOVE,
    PL_LOCK_TURN,
    PL_LOCK_SLIDE,
    PL_LOCK_SHOOT,
    PL_LOCK_CLIMB,
    PL_LOCK_SPRITECHANGE,
    PL_LOCK_GRAVITY,
    PL_LOCK_JUMP,
    PL_LOCK_CHARGE,
    GLOBAL_LOCK_PLAYERFROZEN
);

lock.targetInstance = all
lock.debugInfo += "<playerTimeStopped"
return lock
