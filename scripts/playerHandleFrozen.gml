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
    
    if(enableMashGetout)
    {
        var _mashInput = global.keyLeftPressed[playerID]
            || global.keyRightPressed[playerID]
            || global.keyUpPressed[playerID]
            || global.keyDownPressed[playerID]
            || global.keyJumpPressed[playerID]
            || global.keyShootPressed[playerID]
            || global.keySlidePressed[playerID];
        
        if(mashGetoutCooldownTimer <= 0)
        {
            drawOffsetY = 0;
            if(_mashInput)
            {
                drawOffsetY = -image_yscale;
                freezeTimer -= mashGetoutEffectiveness;
                mashGetoutCooldownTimer = mashGetoutCooldown;
            }
        }
        else
        {
            mashGetoutCooldownTimer--;
            if(mashGetoutCooldownTimer mod 4 < 2) drawOffsetY = -image_yscale;
        }
    }
    
    if (freezeTimer <= 0 || isHit)
    {
        isFrozen = 0;
        icedLock = lockPoolRelease(icedLock);
        playerPalette();
        shootStandStillLock = lockPoolRelease(
            shootStandStillLock);
        isShoot = 0;
        shootTimer = 0;
        enableMashGetout = 1;
        mashGetoutCooldownTimer = 0;
        drawOffsetY = 0;
    }
}
