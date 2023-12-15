/// playerHandleClimbing();

var touchLadder = collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_bottom+1,objLadder,0,1);
if(!touchLadder)
{
    with(prtEntity) if(entityLadder && !dead) // entity ladder
    {
        if(collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_bottom+1,other,0,1)) touchLadder = self;
    }
}

var ladder = noone, ladderUp = noone, ladderDown = noone;

if(touchLadder)
{
    ladder = collision_line(bboxGetXCenter(), bbox_top + 2, bboxGetXCenter(), bbox_bottom, touchLadder, false, true);
    
    ladderUp = instance_position(spriteGetXCenter(), ((bbox_top * (gravDir < 0)) + (bbox_bottom * (gravDir > 0))) - gravDir, touchLadder);
    ladderDown = instance_position(spriteGetXCenter(), ((bbox_top * (gravDir < 0)) + (bbox_bottom * (gravDir > 0))) + gravDir, touchLadder);
}

if (!playerIsLocked(PL_LOCK_CLIMB))
{
    if (((instance_exists(ladder) && gravDir == -yDir && jumpLadderCooldown <= 0)
        || (instance_exists(ladderDown) && !instance_exists(ladderUp) && gravDir == yDir && ground))
        && !climbing)
    {
        // begin climbing:
        var prevXspd = xspeed;
        xspeed = 0;
        
        if (isSlide)
        {
            slideLock = lockPoolRelease(slideLock);
            isSlide = false;
            mask_index = mskMegaman;
            slideTimer = 0;

            shiftObject(0, -gravDir, 0);
        }
        
        climbing = true;
        
        // implemented support for wide ladders
        if (instance_exists(ladder))
        {
            var ladderWidthHalf = abs(ladder.bbox_right-ladder.bbox_left)/2;
            shiftObject((ladder.bbox_left + ladderWidthHalf) - x, 0, true);
            if (x != ladder.bbox_left + ladderWidthHalf)
            {
                climbing = false;
            }
        }
        else
        {
            var prevX = x;
            var prevY = y;
            var ladderWidthHalf = abs(ladderDown.bbox_right-ladderDown.bbox_left)/2;
            shiftObject(ladderDown.bbox_left + ladderWidthHalf - x, 0, true);
            var prevLadderSolid = ladderDown.isSolid;
            ladderDown.isSolid = 0;
            shiftObject(0, climbSpeed * gravDir, true);
            ladderDown.isSolid = prevLadderSolid;
            if (x != ladderDown.bbox_left + ladderWidthHalf)
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
        
        if (climbing)
        {
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
            
            // inherit ladder movement
            /*
            if(touchLadder)
            {
                if(touchLadder.object_index != objLadder && object_get_parent(touchLadder) != objLadder)
                {
                    shiftObject(touchLadder.xspeed,touchLadder.yspeed,1);
                }
            }
            */
        }
    }
    
    if (climbing) // While climbing
    {
        // inherit ladder movement
        /*
        if(touchLadder)
        {
            if(touchLadder.object_index != objLadder && object_get_parent(touchLadder) != objLadder)
            {
                shiftObject(touchLadder.xspeed,touchLadder.yspeed,1);
            }
        }
        */
        // attempt to shove Mega to the middle of the ladder
        if(ladder)
        {
            shiftObject((ladder.bbox_left + ladder.sprite_width/2) - x, 0, true)
        }
        
        if (yDir != 0 && !isShoot) // Movement
        {
            yspeed = climbSpeed * yDir;
            
            // climbing animation
            climbSpriteTimer += 1;
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
        if (!position_meeting(x, bbox_top * (gravDir == 1) + bbox_bottom * (gravDir == -1) + 11 * gravDir, touchLadder)
        // The second check is to make sure the getup animation is not shown when on the BOTTOM of a ladder that's placed in the air
        && position_meeting(x, bbox_bottom * (gravDir == 1) + bbox_top * (gravDir == -1) + gravDir, touchLadder))
        {
            climbing = 2;
            if (!isShoot)
            {
                image_xscale = 1;
            }
        }
        
        // check for other ladders touching Mega to properly release him
        var ladderCheck = 1;
        with(objLadder) if(place_meeting(x,y,other)) ladderCheck = 0;
        with(prtEntity) if(!dead && entityLadder) if(place_meeting(x,y,other)) ladderCheck = 0;
        // Releasing the ladder
        var jump = global.keyJumpPressed[playerID] && ((yDir != -gravDir && !jumpUpLadders) || (jumpUpLadders)) && !playerIsLocked(PL_LOCK_CLIMB);
        if ((ground && yDir == gravDir) || ladderCheck /*!place_meeting(bbox_left, y, touchLadder) || !place_meeting(bbox_right, y, touchLadder)*/ || jump)
        {
            var climbedUp=false;
            if (ladderCheck)
            {
                if (place_meeting(x, y + (gravDir * climbSpeed), touchLadder))
                {   
                    playLandSound=0;
                    ground=false;  
                    climbedUp=true;
                }
            }
    
            climbing = false;
            yspeed = 0;
            isSlide = false;
            jumpCounter = !jumpUpLadders;
            climbLock = lockPoolRelease(climbLock);
            shootStandStillLock = lockPoolRelease(shootStandStillLock);
            image_xscale = ladderXScale;
            if(climbedUp)
            {
                yspeed = gravDir*climbSpeed;
                event_inherited();
            }
            else
            {
                if(jump && jumpUpLadders && yDir != gravDir)
                {
                    playerJump();
                    jumpLadderCooldown = jumpLadderCooldownMax;
                }
            }
        }
    }
}

if(!climbing)
{
    if(jumpLadderCooldown > 0)
    {
        jumpLadderCooldown--;
        if(sign(yspeed) != -gravDir || !instance_exists(ladder)) jumpLadderCooldown = 0;
    }
}

