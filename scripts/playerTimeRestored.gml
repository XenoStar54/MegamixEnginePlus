/// playerTimeRestored(lock id)
// Frees the player's movement (e.g. after being locked)

return lockPoolRelease(PL_LOCK_MOVE,
    PL_LOCK_TURN,
    PL_LOCK_SLIDE,
    PL_LOCK_SHOOT,
    PL_LOCK_CLIMB,
    PL_LOCK_SPRITECHANGE,
    PL_LOCK_GRAVITY,
    PL_LOCK_JUMP,
    PL_LOCK_CHARGE,
    GLOBAL_LOCK_PLAYERFROZEN,
    argument0);
