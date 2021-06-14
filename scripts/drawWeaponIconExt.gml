/// drawWeaponIconExt(weaponID, costumeID, x, y, xscale, yscale, rot, alpha)

_weaponID = argument[0];
_costumeID = argument[1];
_greyed = argument[2];
_x = argument[3];
_y = argument[4];
_xscale = argument[5];
_yscale = argument[6];
_rot = argument[7];
_imageAlpha = argument[8];

_col[0] = make_color_rgb(255, 228, 164);
_col[1] = getWeaponPrimaryColor(_weaponID, _costumeID);
_col[2] = getWeaponSecondaryColor(_weaponID, _costumeID);
_col[3] = c_white;

if (_greyed)
{
    _col[0] = c_white;
}
            
for (_j = 0; _j <= 3 - 3 * _greyed; _j += 1)
{
    draw_sprite_ext(global.weaponIcon[_weaponID], _j, _x, _y,
        _xscale, _yscale, 0, _col[_j], _imageAlpha);
}
