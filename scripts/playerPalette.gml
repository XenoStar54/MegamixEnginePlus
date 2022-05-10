/// playerPalette()
// Change colors depending on the special weapon

// octone ink goes away
inked = false;

// Default Color.
global.primaryCol[playerID] = getWeaponPrimaryColor(global.weapon[playerID], costumeID);
global.secondaryCol[playerID] = getWeaponSecondaryColor(global.weapon[playerID], costumeID);

// used later for charging.
global.outlineCol[playerID] = c_black;

// used for chill man freezing
if (isFrozen)
{
    if (frozenPalettePrimary == 0 && frozenPaletteSecondary == 0 && frozenPaletteOutline == 0)
    {
        global.outlineCol[playerID] = make_color_rgb(0, 128, 136);
        global.primaryCol[playerID] = make_color_rgb(156, 248, 240);
        global.secondaryCol[playerID] = c_white;
    }
    else
    {
        global.outlineCol[playerID] = frozenPaletteOutline;
        global.primaryCol[playerID] = frozenPalettePrimary;
        global.secondaryCol[playerID] = frozenPaletteSecondary;
    }   
}

// The pause menu also resets the colors as to not show charging colors in the Mega Man sprite at the bottom right
if (instance_exists(objPauseMenu))
{
    if (!global.keyPausePressed[playerID])
    {
        chargeTimer = 0;
        initChargeTimer = 0;
    }
}
