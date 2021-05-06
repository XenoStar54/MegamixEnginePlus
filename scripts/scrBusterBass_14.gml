var bulletLimit = 4;
var weaponCost = 0;
var action = 1; // 0 - no frame; 1 - shoot; 2 - throw; 3 - upwards aim; 4 - upwards diagonal aim; 5 - downwards diagonal aim;
var xOffset = 20;
var yOffset = 0;
var willStop = 1; // If this is 1, the player will halt on shooting ala Metal Blade.

var pCanMove = !playerIsLocked(PL_LOCK_MOVE);

//setting the actual action here
if yDir == -1 && xDir == 0
{
    action = 3;
    xOffset = 5;
    yOffset = -11;
    //Technically the clibbing variant is a few pixels off from MM10's...*however* it actually looks more like it's coming from the buster with this, and the engine causes the bullet to die anyway so this is the best compromise.
}
else if yDir == -1 && xDir != 0
{ 
    action = 4;
    xOffset = 18;
    yOffset = -10;
    if (climbing)
    {
        xOffset -= 4;
        yOffset += 1;
    }
}
else if yDir 
{
    action = 5;
    xOffset = 14+4;
    yOffset = 6+4;
    if (climbing)
    {
        xOffset -= 4;
        yOffset -= 1;
    }
}
if (!global.lockBuster)
{
    if (isSlide)//Failsafe for above to cancel once a slide has started.
    {
        exit;
    }
    if (global.keyShoot[playerID] && (!playerIsLocked(PL_LOCK_SHOOT)))
    {
        if shootTimer < 8
        {
            shootTimer++
            shootStandStillLock = lockPoolRelease(shootStandStillLock);
            shootStandStillLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE]);
            
            exit;
        }
        i = fireWeapon(xOffset, yOffset, objBusterShot, bulletLimit, weaponCost, action, willStop);
        isShoot = action;
        xspeed = 0;
        
        //printErr(shootTimer);
        if (i)
        {
            i.sprite_index = sprBassBullet;
            i.dir = 0;
        
            if (image_xscale < 0)
            {
                i.dir += 180;
            }
        
            if (yDir != 0)
            {
                i.dir -= (yDir * 90) * image_xscale;
                if (xDir != 0 || yDir == 1)
                {
                    i.dir += (yDir * 45) * image_xscale;
                }
            }
            with (i)
            {
                scrBusterBass_Step();//Run once to get x and y speeds. Also fixes problems with MM9's gravity lift.
            }
        }
        else
        {
            shootStandStillLock = lockPoolRelease(shootStandStillLock);
            shootStandStillLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE]);
            shootTimer = 8;//min(shootTimer,15);
            
        }
        //stepTimer = 0;
    }
    else if (shootTimer >= 16)//If part of this statement and new ending-else below is a fix for Turbo-firing, an issue I still gotta fix with MM2-Bass. -Gannio//if shootTimer >= 14 //making sure it doesn't release the lock until it stops being held
    {
        shootTimer = 16;//14;
        
    }
    else
    {
        shootTimer++;
    }
    /*if (!ground)
    {
        stepFrames = 0;
    }*///printErr(xDir);//stepTimer);
    
    //if (!global.keyShoot[playerID] && isShoot && ground)
    //{
        //spriteLoopID = 0;
    //}
}
