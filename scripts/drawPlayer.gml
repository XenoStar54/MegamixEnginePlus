/// drawPlayer(playerID, costumeID, sheetX, sheetY, x, y, xscale, yscale)
// draws the given player at the given position
// invokes drawCostume with the correct values
// sheetX, sheetY: coord (in 48x48 units) of the animation frame in the skin sheet.

var pid = argument0,
    cid = argument1,
    sheetX = argument2,
    sheetY = argument3,
    _x = argument4,
    _y = argument5,
    _xscale = argument6,
    _yscale = argument7;

var _inked = false;
var baseCol = c_white;
if (instance_exists(objMegaman))
{
    with (objMegaman)
    {
        if (inked && playerID == pid)
        {
            _inked = true;
            baseCol = c_ltgray;
        }
    }
}


col[0] = c_white;
col[1] = global.primaryCol[pid];
col[2] = global.secondaryCol[pid];
col[3] = global.outlineCol[pid];
if object_index == objMegaman
{
if (weaponFlash > 5)
{
    col[2] = c_white;
}
if (weaponFlash)
{
    col[1] = c_white;
}
}

if (!_inked)
{
    drawCostume(global.playerSprite[cid], sheetX, sheetY, _x, _y, _xscale, _yscale,
        baseCol, col[1],
        col[2], global.outlineCol[pid], image_alpha, image_alpha, image_alpha, image_alpha);
}

// octone ink handling:

if (_inked)
{
    drawPlayerInk(pid, sheetX, sheetY, _x, _y, _xscale, _yscale);
}
