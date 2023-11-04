//THE ACTUAL STEP EVENT
if (!global.frozen && !frozen)
{
    playerStep(); // General step event code
    
    if (!playerIsLocked(PL_LOCK_PHYSICS))
    {
        var iscl = image_xscale;
        image_xscale=1;//Ensure a symmetrical mask
        event_inherited(); // General prtEntity code
        image_xscale=iscl;
        playerMovement();
    }
    
    // Shooting
    if (instance_exists(statusObject))
    {
        if (statusObject.statusCanShoot)
        {
            playerHandleShoot();
        }
    }
    else
    {
        playerHandleShoot();
    }
    
    // Quick weapon switching
    playerSwitchWeapons();
    
    // Handle the sprites
    playerHandleSpritesProto('Normal');
    
    // Moving from one section to the next, if possible
    playerSwitchSections();
    
    // Recover from mm1 stun
    playerHandleStun();
    
    if !instance_exists(myProtoShield)
    {
        myProtoShield = instance_create(x, y, objProtoShield)
        myProtoShield.parent = id;
    }
    
    // weapon wheel
    if (!instance_exists(objPauseMenu) && !playerIsLocked(PL_LOCK_PAUSE))
    {
        if(global.keyWeaponWheelPressed[playerID])
        {
            if (global.playerHealth[playerID] > 0)
            {
                var wheel = instance_create(x, y, objWeaponWheel);
                wheel.playerID = playerID;
                wheel.parent = self;
            }
        }
    }
}
