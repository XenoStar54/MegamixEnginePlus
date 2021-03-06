/// scrBusterProto_14([canCharge?], [canStartShoot], [sfx])
var _canCharge = true;
if (argument_count > 0)
{
    _canCharge = argument[0];
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

var bulletLimit = 2;
var weaponCost = 0;
var action = 1; // 0 - no frame; 1 - shoot; 2 - throw
var willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

var chargeTime = 57; // Set charge time for this weapon
var initChargeTime = 20;

// make all charge levels count for eachother
var shots = 0;
var halfShots = 0;
var fullShots = 0;
with (prtPlayerProjectile)
{
    if (playerID == other.playerID)
    {
        if (object_index == objBusterShot)
        {
            shots++;
        }
        else if (object_index == objBusterShotHalfChargedProto)
        {
            halfShots++;
        }
        else if (object_index == objBusterShotChargedProto)
        {
            fullShots++;
        }
    }
}

if (!global.lockBuster)
{
    if (_canStartShoot && global.keyShootPressed[playerID]
        && !playerIsLocked(PL_LOCK_SHOOT) && chargeTimer == 0)
    {
        i = fireWeapon(16, 0, objBusterShot, bulletLimit - halfShots - fullShots, weaponCost, action, willStop);
        if (i)
        {
            playSFX(_sfx);
            if(_sfx == sfxBusterGBI)
            {
                i.sprite_index = sprBusterShotGB;
                i.ReflectSFX = sfxReflectGBI;
            }
            i.xspeed = image_xscale * 5; // zoom
        }
    }
    
    //////////////
    // Charging //
    //////////////
    
    if (global.enableCharge && _canCharge)
    {
        if ((global.keyShoot[playerID] || (isSlide && chargeTimer > 0))
            && !playerIsLocked(PL_LOCK_CHARGE) && (_canStartShoot || initChargeTimer > 0))
        {
            if (!isShoot)
            {
                isCharge = true;
                
                if (!isSlide)
                {
                    initChargeTimer += 1;
                }
                
                if (initChargeTimer >= initChargeTime)
                {
                    if (!chargeTimer)
                    {
                        playSFX(sfxProtoCharging);
                    }
                    
                    chargeTimer++;
                    
                    if (chargeTimer < chargeTime)
                    {
                        var chargeTimeDiv, chargeCol;
                        chargeTimeDiv = round(chargeTime / 3);
                        
                        if (chargeTimer < chargeTimeDiv)
                        {
                            chargeCol = make_color_rgb(168, 0, 32); // Dark red
                        }
                        else if (chargeTimer < chargeTimeDiv * 2)
                        {
                            chargeCol = make_color_rgb(228, 0, 88); // Red (dark pink)
                        }
                        else
                        {
                            chargeCol = make_color_rgb(248, 88, 152); // Light red (pink)
                        }
                        
                        if (chargeTimer mod 6 >= 0 && chargeTimer mod 6 < 3)
                        {
                            global.outlineCol[playerID] = chargeCol;
                        }
                        else
                        {
                            global.outlineCol[playerID] = c_black;
                        }
                    }
                    else
                    {
                        if (chargeTimer == chargeTime)
                        {
                            audio_stop_sound(sfxCharging);
                        }
                        if (!inked)
                        {
                            switch (floor(chargeTimer / 3 mod 3))
                            {
                                case 0: // Light blue helmet, black shirt, blue outline 
                                    global.primaryCol[playerID] = rockSecondaryCol;
                                    global.secondaryCol[playerID] = c_black;
                                    global.outlineCol[playerID] = rockPrimaryCol;
                                    break;
                                case 1: // Black helmet, blue shirt, light blue outline 
                                    global.primaryCol[playerID] = c_black;
                                    global.secondaryCol[playerID] = rockPrimaryCol;
                                    global.outlineCol[playerID] = rockSecondaryCol;
                                    break;
                                case 2: // Blue helmet, light blue shirt, blue outline 
                                    global.primaryCol[playerID] = rockPrimaryCol;
                                    global.secondaryCol[playerID] = rockSecondaryCol;
                                    global.outlineCol[playerID] = c_black;
                                    break;
                            }
                        }
                    }
                }
            }
        }
        else // Release the charge shot
        {
            if (!playerIsLocked(PL_LOCK_SHOOT) && chargeTimer != 0 && !isSlide)
            {
                /////////////////////
                // ACTUAL SHOOTING //
                /////////////////////
                
                if (chargeTimer < chargeTime) // Half charge
                {
                    i = fireWeapon(12, 0, objBusterShotHalfChargedProto, bulletLimit - shots - fullShots, weaponCost, action, willStop);
                    if (i)
                    {
                        i.xspeed = image_xscale * 5;
                    }
                }
                else // Full charge
                {
                    i = fireWeapon(20, 0, objBusterShotChargedProto, bulletLimit - shots - halfShots, 0, 1, 0);
                    if (i)
                    {
                        i.xspeed = image_xscale * 5.5;
                    }
                }
                
                // Reset all charging stuff
                chargeTimer = 0;
                initChargeTimer = 0;
                audio_stop_sound(sfxProtoCharging);
                playerPalette(); // Reset the colors
            }
        }
    }
}
