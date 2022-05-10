/// getWeaponSecondaryColor(weaponID, costumeID)
_n = global.weaponSecondaryColor[argument[0]];
_c = argument[1];

if (_n >= 0)
{
    return _n;
}
else
{
    // special cases
    
    // Default Color.
    switch (global.playerSprite[_c])
    {
        default: // default is mega man colors
        // TODO: these should not be implemented in code :P
        case sprRockman:
            if (global.mmColor)
            {
                rockSecondaryCol = make_color_rgb(56, 184, 248);
            }
            else
            {
                rockSecondaryCol = make_color_rgb(0, 232, 216);
            }
            
            rushSecondaryCol = make_color_rgb(255, 255, 255);
            sakugarneSecondaryCol = rockSecondaryCol;
            break;
            
        case sprProtoman:
            rockSecondaryCol = make_color_rgb(188, 188, 188);
            rockSecondaryCol = make_color_rgb(188, 188, 188);
            sakugarneSecondaryCol = rockSecondaryCol;
            break;
            
        case sprBass:
            rockSecondaryCol = make_color_rgb(248, 152, 56);
            rushSecondaryCol = make_color_rgb(128, 0, 240);
            sakugarneSecondaryCol = rockSecondaryCol;
            break;
            
        case sprRoll:
            rockSecondaryCol = make_color_rgb(0, 168, 0);
            rushSecondaryCol = make_color_rgb(168, 224, 248);
            sakugarneSecondaryCol = rockSecondaryCol;
            break;
    }
    
    switch (_n)
    {
        default:
        case -1: return rockSecondaryCol;
        case -2: return rushSecondaryCol;
        case -3: return sakugarneSecondaryCol;
    }
}
