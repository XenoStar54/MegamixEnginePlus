/// drawPaletteSprite(sprPaletteSprite, subImage, x, y, pltPalette, paletteLength)
// sprPaletteSprite - the sprite to draw
// pltSwapPalette - the sprite of the palette to draw the given sprite with. Must be 32 in width and have "Use for 3D" checked!!!!!!!!!
// paletteLength - the length of the palette

var _sprite = argument0;
var _subImg = argument1;
var _x = argument2;
var _y = argument3;
var _palette = argument4;
var _size = argument5;

if (!global.shadersEnabled)
{
    draw_sprite(_sprite, _subImg, _x, _y);
    exit;
}

shader_set(shdPaletteSwap);
texture_set_stage(shader_get_sampler_index(shdPaletteSwap, "swapPalette"), sprite_get_texture(_palette, 0));
shader_set_uniform_f(shader_get_uniform(shdPaletteSprite, "paletteLength"), _size);
draw_sprite(_sprite, _subImg, _x, _y);
shader_reset();

