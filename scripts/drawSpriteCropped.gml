/// drawSpriteCropped(sprite, image index, x, y, left, top, right, bottom, xscale, yscale, colour, alpha)
// draws the given sprite as usual, but constrained to the given rectangle.
// a more convenient interface to draw_sprite_ext

var spr = argument0;
var img = argument1;
var _x = argument2;
var _y = argument3;
var left = argument4;
var top = argument5;
var width = argument6 - argument4 + 1;
var height = argument7 - argument5 + 1;
var xscale = argument8;
var yscale = argument9;
var colour = argument10;
var alpha = argument11;
var sprWidth = sprite_get_width(spr) * xscale;
var sprHeight = sprite_get_height(spr) * yscale;

// so the trick to drawing negative scale cropped sprites is that you have to invert width/height
// something which the script already fucking does lmfao

var trueX = max(_x, left);
var trueY = max(_y, top);
var trueRight = left + width;
var trueBottom = top + height;
var trueWidth = trueRight - trueX;
var trueHeight = trueBottom - trueY;
var sprLeft, sprTop_, sprWidth, sprHeight;

// xscale
if (xscale != 0)
{
    sprLeft = (trueX - _x) / xscale;
    sprWidth = trueWidth / xscale;
}
else
{
    exit;
}

// yscale
if (yscale != 0)
{
    sprTop_ = (trueY - _y) / yscale;
    sprHeight = trueHeight / yscale;
}
else
{
    exit;
}
draw_sprite_part_ext(spr, img, sprLeft, sprTop_, sprWidth, sprHeight, trueX, trueY, xscale, yscale, colour, alpha);
