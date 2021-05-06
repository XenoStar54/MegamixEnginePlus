/// playerLockMovement()
// Locks the player's control input, returning a lock ID which must
// be used in the subsequent call to playerFreeMovement(lock ID)

with (objMegaman)
{
    climbing = false;
    isSlide = false;
    climbLock = lockPoolRelease(climbLock);
    slideLock = lockPoolRelease(slideLock);
    slideChargeLock = lockPoolRelease(slideChargeLock);
    mask_index = mskMegaman;
    xspeed = 0;
}

var lock = lockPoolLock(PL_LOCK_MOVE,
    PL_LOCK_TURN,
    PL_LOCK_JUMP,
    PL_LOCK_SLIDE,
    PL_LOCK_PAUSE,
    PL_LOCK_SHOOT,
    PL_LOCK_CLIMB,
    PL_LOCK_JUMP,
    PL_LOCK_CHARGE,
    GLOBAL_LOCK_PLAYERFROZEN);

lock.targetInstance = all
lock.debugInfo += "<playerLockMovement"
return lock
