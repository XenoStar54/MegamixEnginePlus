/// playerHandleFrozen();

// Being frozen
if (isFrozen)
{
    freezeTimer -= 1;
    xspeed = 0;
    yspeed = 0;
    
    if (!icedLock)
    {
        icedLock = lockPoolLock(PL_LOCK_MOVE,
            PL_LOCK_TURN,
            PL_LOCK_SLIDE,
            PL_LOCK_SHOOT,
            PL_LOCK_CLIMB,
            PL_LOCK_SPRITECHANGE,
            PL_LOCK_GRAVITY,
            PL_LOCK_JUMP,
            PL_LOCK_CHARGE);
        icedLock.targetInstance = id
        icedLock.debugInfo += "<playerHandleFrozen"
    }
    
    if (!freezeTimer || isHit)
    {
        isFrozen = 0;
        icedLock = lockPoolRelease(icedLock);
        playerPalette();
        shootStandStillLock = lockPoolRelease(
            shootStandStillLock);
        isShoot = 0;
        shootTimer = 0;
    }
}
