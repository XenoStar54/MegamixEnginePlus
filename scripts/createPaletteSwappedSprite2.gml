/// createPaletteSwappedSprite2(sprPaletteSprite, pltSwapPalette, paletteLength)
// sprPaletteSprite - the palette sprite to create a palette swap sprite of.
// pltSwapPalette - the sprite of the palette to apply to the given sprite. Must be 32 in width and have "Use for 3D" checked!!!!!!!!!
// paletteLength - the length of the palette

/* Creates a sprite with the given palette baked in. */

// MUST BE DONE IN A DRAW EVENT!

// MAKE SURE YOU DELETE THE SPRITE WHEN YOU DON'T NEED IT ANYMORE! THE ORIGINAL PALETTE SPRITE TOO!

var _sprite = argument0;
var _palette = argument1;
var _length = argument2;

if (!global.shadersEnabled)
{
    return sprite_duplicate(_sprite);
}

// setup surface and shader
var p = powerOfTwo(sprite_get_width(_sprite), sprite_get_height(_sprite));
var _tempSurface = surface_create(p, p);

surface_set_target(_tempSurface);

shader_set(shdPaletteSwap);
texture_set_stage(shader_get_sampler_index(shdPaletteSwap, "swapPalette"), sprite_get_texture(_palette, 0));
shader_set_uniform_f(shader_get_uniform(shdPaletteSwap, "paletteLength"), _length);

// create sprite and add its sub-images
var _swappedSprite = noone;
var _num = sprite_get_number(_sprite);
for (var _i = 0; _i < _num; _i++)
{
    draw_clear_alpha(0, 0);
    draw_sprite(_sprite, _i, sprite_get_xoffset(_sprite), sprite_get_yoffset(_sprite));
    
    if (_i == 0)
    {
        _swappedSprite = sprite_create_from_surface(_tempSurface, 0, 0, sprite_get_width(_sprite), sprite_get_height(_sprite),
            0, 0, sprite_get_xoffset(_sprite), sprite_get_yoffset(_sprite));
    }
    else
    {
        sprite_add_from_surface(_swappedSprite, _tempSurface, 0, 0, sprite_get_width(_sprite), sprite_get_height(_sprite),
            0, 0);
    }
}

// cleanup
shader_reset();
surface_reset_target();
surface_free(_tempSurface);

// return
return _swappedSprite;

