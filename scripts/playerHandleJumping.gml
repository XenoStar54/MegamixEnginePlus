/// playerHandleJumping();

if (!playerIsLocked(PL_LOCK_JUMP))
{
    if (ground)
    {
        jumpCounter = 0;
        if(coyoteTimeMax < 0) coyoteTime = coyoteTimeMax;
        else coyoteTime = 0;
        dashJumped = false;
    }
    else
    {
        if(sign(yspeed) == -gravDir) coyoteTime = coyoteTimeMax+1;
        else if(coyoteTime <= coyoteTimeMax && coyoteTimeMax >= 0) coyoteTime++;
    }
    if (global.keyJumpPressed[playerID] && yDir != gravDir)
    {
        if (ground || jumpCounter < jumpCounterMax)
        {
            playerJump();
            coyoteTime = coyoteTimeMax+1;
        }
    }
    else if (!global.keyJump[playerID]) // Minjumping (lowering jump when the jump button is released)
    {
        if (yspeed * gravDir < 0 && canMinJump)
        {
            canMinJump = false;
            yspeed = 0;
        }
    }
}
