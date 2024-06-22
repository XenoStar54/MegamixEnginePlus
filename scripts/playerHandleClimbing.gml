/// playerHandleClimbing();

var touchLadder = instance_place(x,y+gravDir,objLadder);
if(!touchLadder)
{
    with(prtEntity) if(entityLadder && !dead) // entity ladder
    {
        with(other) if(place_meeting(x,y+gravDir,other)) touchLadder = other;
    }
}

if (!playerIsLocked(PL_LOCK_CLIMB))
{
    var maxLadderDistance = 8;
    
    if (((place_meeting(x,y,touchLadder) && gravDir == -yDir && jumpLadderCooldown <= 0)
        || (!place_meeting(x,y,touchLadder) && gravDir == yDir && ground))
        && !climbing && instance_exists(touchLadder)
        && abs(x - bboxGetXCenterObject(touchLadder)) <= maxLadderDistance)
    {
        // begin climbing:
        var prevXspd = xspeed;
        
        climbing = true;
        
        // implemented support for wide ladders
        if (instance_exists(touchLadder))
        {
            if (place_meeting(x,y,touchLadder) && gravDir == -yDir) // catching a ladder Mega is touching
            {
                var ladderWidthHalf = abs(touchLadder.bbox_right-touchLadder.bbox_left)/2;
                shiftObject((touchLadder.bbox_left + ladderWidthHalf) - x, 0, true);
                if (x != touchLadder.bbox_left + ladderWidthHalf)
                {
                    climbing = false;
                }
            }
            else if (place_meeting(x,y+gravDir,touchLadder) && gravDir == yDir && ground) // going down on a ladder Mega's standing on
            {
                var prevX = x;
                var prevY = y;
                var ladderWidthHalf = abs(touchLadder.bbox_right-touchLadder.bbox_left)/2;
                shiftObject(touchLadder.bbox_left + ladderWidthHalf - x, 0, true);
                var prevLadderSolid = touchLadder.isSolid;
                touchLadder.isSolid = 0;
                shiftObject(0, climbSpeed * gravDir, true);
                touchLadder.isSolid = prevLadderSolid;
                if (x != touchLadder.bbox_left + ladderWidthHalf)
                {
                    climbing = false;
                }
                // if failed to climb the ladder, return
                if(y == prevY)
                {
                    shiftObject(prevX - x, 0, true);
                    xspeed = prevXspd;
                    climbing = false;
                }
            }
        }
        
        if (climbing)
        {
            xspeed = 0;
            saveLadder = touchLadder;
            
            if (isSlide)
            {
                slideLock = lockPoolRelease(slideLock);
                isSlide = false;
                mask_index = mskMegaman;
                slideTimer = 0;
    
                shiftObject(0, -gravDir, 0);
            }
            
            climbLock = lockPoolLock(PL_LOCK_MOVE,
                PL_LOCK_SLIDE,
                PL_LOCK_GRAVITY,
                PL_LOCK_TURN);
            climbLock.targetInstance = id
            climbLock.debugInfo += "<playerHandleClimbing"
            
            ground = false;
            jumpCounter = 0;
            yspeed = 0;
            ladderXScale = image_xscale;
            climbShootXscale = ladderXScale;
        }
    }
    
    if (climbing) // While climbing
    {
        // attempt to shove Mega to the middle of the ladder
        if(touchLadder)
        {
            shiftObject((touchLadder.bbox_left + touchLadder.sprite_width/2) - x, 0, true)
        }
        
        if (yDir != 0) // Movement
        {
            if(!isShoot)
            {
                yspeed = climbSpeed * yDir;
            }
            else
            {
                yspeed = climbShootSpeed * yDir;
            }
            
            // climbing animation
            climbSpriteTimer += (yspeed != 0);
            if (!(climbSpriteTimer mod 8))
            {
                if (spriteX == 15)
                {
                    spriteX = 16;
                }
                else if (spriteX == 16)
                {
                    spriteX = 15;
                }
            }
        }
        else
        {
            yspeed = 0;
        }
        
        if (xDir != 0) // Left/right
        {
            climbShootXscale = xDir;
        }
        
        climbing = 1;
        
        // Getup sprite
        if(touchLadder)
        {
            if( place_meeting(x,y,touchLadder)
                && ((gravDir > 0 && (bbox_top+8) < touchLadder.bbox_top)
                || ((gravDir < 0 && (bbox_bottom-8) > touchLadder.bbox_bottom))) )
            {
                climbing = 2;
            }
        }
        
        // check for ladder touching Mega to properly release him
        var ladderCheck = 1;
        if(touchLadder && place_meeting(x, y, touchLadder))
        {
            saveLadder = touchLadder;
            ladderCheck = 0;
        }
        // Releasing the ladder
        var jump = global.keyJumpPressed[playerID] && ((yDir != -gravDir && !jumpUpLadders) || (jumpUpLadders)) && !playerIsLocked(PL_LOCK_CLIMB);
        if ((ground && yDir == gravDir) || ladderCheck || jump)
        {
            var climbedUp=false;
            if (ladderCheck)
            {
                show_debug_message("I'm on top of the ladder!");
                //shiftObject(0,-gravDir*climbSpeed*1,0);
                if (saveLadder && !place_meeting(x, y, saveLadder) && place_meeting(x, y + (gravDir * climbSpeed * 2), saveLadder) && yDir == -gravDir)
                {
                    climbedUp=true;
                    show_debug_message("I have climbed up!");
                }
                //shiftObject(0,gravDir*climbSpeed*1,0);
            }
    
            climbing = false;
            yspeed = 0;
            isSlide = false;
            jumpCounter = !jumpUpLadders;
            climbLock = lockPoolRelease(climbLock);
            shootStandStillLock = lockPoolRelease(shootStandStillLock);
            image_xscale = ladderXScale;
            if(climbedUp) // drastic af actions
            {
                ground = true;
                playLandSound=0;
                shiftObject(0,gravDir*climbSpeed*2,1);
                yspeed = gravDir*climbSpeed*2;
                event_inherited();
                ground = true;
                playLandSound=0;
            }
            else
            {
                if(jump && jumpUpLadders && yDir != gravDir)
                {
                    playerJump();
                    jumpLadderCooldown = jumpLadderCooldownMax;
                }
            }
            saveLadder = noone;
        }
    }
}

if(!climbing)
{
    if(jumpLadderCooldown > 0)
    {
        jumpLadderCooldown--;
        if(sign(yspeed) != -gravDir || !instance_exists(touchLadder)) jumpLadderCooldown = 0;
    }
}

