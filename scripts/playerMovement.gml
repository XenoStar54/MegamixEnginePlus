if (!instance_exists(vehicle) && !instance_exists(myTrebleBoost)
    && !instance_exists(myRushMarine))
{
    if (ycoll * gravDir > 0)
    {
        if (playLandSound > 2 && !isHit && !climbing)
        {
            if (global.jumpSound)
            {
                playSFX(sfxLandClassic);
            }
            else
            {
                playSFX(sfxLand);
            }
        }
    }
}

// Stop movement at section borders (horizontal)
var xdis = x - (view_xview + ((view_wview * 0.5)));
var xpos = (view_wview * 0.5)-6;

if (abs(xdis) > xpos)
{
    if ((xdis >= 0 && (!place_meeting(x, y, objSectionArrowRight) || global.lockTransition))
        || (xdis < 0 && (!place_meeting(x, y, objSectionArrowLeft) || global.lockTransition)))
    {
        x = view_xview + (view_wview * 0.5) + xpos * sign(xdis);
        xspeed = 0;
        
        if (position_meeting(x,y,objSolid) && blockCollision)
        {
            global.playerHealth[playerID] = 0;
        }
    }
}


// stop movement at section borders (vertical)
var ydis = y - (view_yview + (view_hview * 0.5));
var ypos = (view_hview * 0.5) + 32;

if (ydis * gravDir < -ypos)
{
    y = view_yview + (view_hview * 0.5) + ypos * sign(ydis);
}
else if (dieToPit)
{
    if (ydis * gravDir > ypos - 16)
    {
        if ((gravDir >= 0 && !position_meeting(x, y - 8, objSectionArrowDown))
            || (gravDir < 0 && !place_meeting(x, y + 8, objSectionArrowUp)))
        {
            //global.playerHealth[playerID] = 0;
            //deathByPit = true;
            
            // are we on a vehicle it's okay to dismount to be saved by beat
            var onDismountable = false;
            if (instance_exists(vehicle))
            {
                // code list of dismountable vehicles here
                if (vehicle.object_index == objRushCycle
                    /*|| vehicle.object_index == objRushMarine*/)
                {
                    onDismountable = true;
                }
            }
            
            // beat call / death from pit
            if ((!instance_exists(vehicle) || onDismountable) && (global.beatCalls > 0
                || (global.difficulty == DIFF_EASY && global.playerHealth[playerID] > 7)
                || (global.weapon[playerID] == global.weaponID[? objBeat]
                    && global.ammo[playerID, global.weapon[playerID]] > 0)))
            {
                // find / create beat object to send to rescue
                var beat = noone;
                if (instance_exists(objBeat))
                {
                    // command beat that already is out
                    with (objBeat)
                    {
                        if (playerID == other.playerID)
                        {
                            beat = id;
                        }
                    }
                }
                
                if (beat == noone)
                {
                    // create new beat
                    beat = instance_create(bboxGetXCenter(), view_yview[0] - 8, objBeat);
                    if (image_yscale < 0)
                    {
                        beat.y = view_yview[0] + view_hview[0] + 8;
                    }
                    
                    beat.isWeapon = false;
                    beat.parent = id;
                    beat.playerID = playerID;
                    beat.costumeID = costumeID;
                }
                
                if (!beat.rescue)
                {
                    // get player off of rush bike
                    if (onDismountable)
                    {
                        with (vehicle)
                        {
                            instance_destroy();
                        }
                    }
                    
                    // start rescuing
                    var playerLock = lockPoolLock(PL_LOCK_MOVE,
                        PL_LOCK_JUMP,
                        PL_LOCK_SLIDE,
                        PL_LOCK_GRAVITY);
                    
                    canHit = false;
                    beat.playerLock = playerLock;
                    beat.rescue = true;
                    xspeed = 0;
                    yspeed = 0;
                    
                    // drain stuff
                    if (global.beatCalls > 0)
                    {
                        // use a beat call
                        global.beatCalls--;
                    }
                    else if (beat.isWeapon
                        && global.weapon[playerID] == global.weaponID[? objBeat]
                        && global.ammo[playerID, global.weapon[playerID]] > 0)
                    {
                        // use weapon energy
                        global.ammo[playerID, global.weapon[playerID]] = max(0, global.ammo[playerID, global.weapon[playerID]] - 6);
                    }
                    else
                    {
                        // take damage in easy mode and get saved by beat
                        global.damage = 7;
                        isHit = false; // hit through invincibility
                        
                        event_user(EV_HURT);
                    }
                    
                    playSFX(sfxBeat);
                }
            }
            else
            {
                var rescuing = false;
                with (objBeat)
                {
                    if (rescue)
                    {
                        rescuing = true;
                    }
                }
                
                if (!rescuing)
                {
                    // death by pit
                    global.playerHealth[playerID] = 0;
                    deathByPit = true;
                }
            }
        }
    }
}

// Handling of masks to make sure nothing breaks
if (!isSlide && (mask_index == firstSlideMask || mask_index == secondSlideMask))
{
    mask_index = mskMegaman;
}
