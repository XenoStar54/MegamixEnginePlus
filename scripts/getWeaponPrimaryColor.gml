/// getWeaponPrimaryColor(weaponID, costumeID)
_n = global.weaponPrimaryColor[argument[0]];
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
                rockPrimaryCol = make_color_rgb(0, 112, 236);
            }
            else
            {
                rockPrimaryCol = make_color_rgb(0, 120, 248);
            }
            
            rushPrimaryCol = make_color_rgb(216, 40, 0);
            sakugarnePrimaryCol = rockPrimaryCol; // make_color_rgb(0, 184, 0);
            break;
            
        case sprProtoman:
            rockPrimaryCol = make_color_rgb(220, 40, 0);
            rushPrimaryCol = make_color_rgb(216, 40, 0);
            sakugarnePrimaryCol = rockPrimaryCol; // make_color_rgb(0, 184, 0);
            break;
            
        case sprBass:
            rockPrimaryCol = make_color_rgb(112, 112, 112);
            rushPrimaryCol = make_color_rgb(112, 112, 112);
            sakugarnePrimaryCol = rockPrimaryCol; // make_color_rgb(0, 184, 0);
            break;
            
        case sprRoll:
            rockPrimaryCol = make_color_rgb(248, 56, 0);
            rushPrimaryCol = make_color_rgb(0, 160, 0);
            sakugarnePrimaryCol = rockPrimaryCol; // make_color_rgb(0, 184, 0);
            break;
    }
    
    switch (_n)
    {
        default:
        case -1: return rockPrimaryCol;
        case -2: return rushPrimaryCol;
        case -3: return sakugarnePrimaryCol;
    }
}
