// scrBusterBass_14([canAim?], [canStartShoot], [sfx])
var _canAim = true;
if (argument_count > 0)
{
    _canAim = argument[0];
}

var _canStartShoot = true;
if (argument_count > 1)
{
    _canStartShoot = argument[1];
}

var _sfx = true;
if (argument_count > 2)
{
    _sfx = argument[2];
}

var bulletLimit = 4;
var weaponCost = 0;
var action = 1; // 0 - no frame; 1 - shoot; 2 - throw; 3 - upwards aim; 4 - upwards diagonal aim; 5 - downwards diagonal aim;
var xOffset = 20;
var yOffset = 0;
var willStop = 1; // If this is 1, the player will halt on shooting ala Metal Blade.

var pCanMove = !playerIsLocked(PL_LOCK_MOVE);

//setting the actual action here
if (_canAim)
{
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
}

if (!global.lockBuster && _canStartShoot)
{
    if (isSlide) // Failsafe for above to cancel once a slide has started.
    {
        exit;
    }
    if (global.keyShoot[playerID] && (!playerIsLocked(PL_LOCK_SHOOT)))
    {
        // pause between shots
        if (shootTimer < 8)
        {
            shootTimer++
            exit;
        }
        
        // making sure it doesn't release the move lock until shoot stops being held
        if (shootTimer >= 14) 
        {
            shootTimer = 14;
        }
        
        // fire bullet
        i = fireWeapon(xOffset, yOffset, objBusterShot, bulletLimit, weaponCost, action, willStop);
        isShoot = action;
        xspeed = 0;
        
        if (i)
        {
            
            playSFX(_sfx);
            if(_sfx == sfxBusterGBI)
            {
                i.ReflectSFX = sfxReflectGBI;
            }
            i.sprite_index = sprBassBullet;
            i.dir = 0;
        
            if (image_xscale < 0)
            {
                i.dir += 180;
            }
        
            if (_canAim && yDir != 0)
            {
                i.dir -= (yDir * 90) * image_xscale;
                if (xDir != 0 || yDir == 1)
                {
                    i.dir += (yDir * 45) * image_xscale;
                }
            }
            
            //Run once to get x and y speeds. Also fixes problems with MM9's gravity lift.
            with (i)
            {
                scrBusterBass_Step();
            }
        }
    }
    else if (shootTimer >= 16)
    {
        shootTimer = 16;
    }
    else
    {
        shootTimer++;
    }
}
