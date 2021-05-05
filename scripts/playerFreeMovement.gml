/// playerFreeMovement(lock ID)
// Frees the player's movement after being locked
// must provide the lock ID given by playerLockMovement

return lockPoolRelease(
    PL_LOCK_MOVE,
    PL_LOCK_TURN,
    PL_LOCK_SLIDE,
    PL_LOCK_PAUSE,
    PL_LOCK_SHOOT,
    PL_LOCK_CLIMB,
    PL_LOCK_JUMP,
    PL_LOCK_CHARGE,
    GLOBAL_LOCK_PLAYERFROZEN,
    argument0
);
