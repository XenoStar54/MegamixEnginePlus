/// drawPaletteSpriteExt(sprPaletteSprite, subImage, x, y, xscale, yscale, rot, colour, alpha, pltPalette, paletteLength)
// sprPaletteSwapSprite - the sprite to draw
// pltSwapPalette - the sprite of the palette to draw the given sprite with. Must be 32 in width and have "Use for 3D" checked!!!!!!!!!
// paletteLength - the length of the palette

var _sprite = argument0;
var _subImg = argument1;
var _x = argument2;
var _y = argument3;
var _xscale = argument4;
var _yscale = argument5;
var _rot = argument6;
var _colour = argument7;
var _alpha = argument8;
var _palette = argument9;
var _size = argument10;

if (!global.shadersEnabled)
{
    draw_sprite_ext(_sprite, _subImg, _x, _y, _xscale, _yscale, _rot, _colour, _alpha);
    exit;
}

shader_set(shdPaletteSwap);
texture_set_stage(shader_get_sampler_index(shdPaletteSwap, "swapPalette"), sprite_get_texture(_palette, 0));
shader_set_uniform_f(shader_get_uniform(shdPaletteSprite, "paletteLength"), _size);
draw_sprite_ext(_sprite, _subImg, _x, _y, _xscale, _yscale, _rot, _colour, _alpha);
shader_reset();

