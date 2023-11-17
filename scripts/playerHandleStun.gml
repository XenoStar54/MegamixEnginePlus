if (shockedTime > 1)
{
    shockedTime -= 1;
    
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
}
else
{
    mm1Stun = false;
    isShocked = false;
    shockedTime = 0;
    shockLock = lockPoolRelease(shockLock);
    mashGetoutCooldownTimer = 0;
    drawOffsetY = 0;
    enableMashGetout = 1;
}
