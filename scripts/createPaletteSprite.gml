/// createPaletteSprite(sprSprite, pltBasePalette, paletteLength)
// sprSprite - the sprite to create a palette swap sprite of.
// pltBasePalette - the sprite of the palette with the colors of the given sprite. Must be 32 in width and have "Use for 3D" checked!!!!!!!!!
// paletteLength - the length of the palette

/* Creates a sprite with color values that represent the locations of the original
colors in the given palette. Store this and draw it using shdPaletteSwap to give the
sprite any palette you want. */

// MUST BE DONE IN A DRAW EVENT!

// MAKE SURE YOU DELETE THE SPRITE WHEN YOU DON'T NEED IT ANYMORE!

var _sprite = argument0;
var _palette = argument1;
var _length = argument2;

if (!global.shadersEnabled)
{
    return _sprite;
}

// setup surface and shader
var p = powerOfTwo(sprite_get_width(_sprite), sprite_get_height(_sprite));
var _tempSurface = surface_create(p, p);

surface_set_target(_tempSurface);

shader_set(shdPaletteSprite);
texture_set_stage(shader_get_sampler_index(shdPaletteSprite, "basePalette"), sprite_get_texture(_palette, 0));
shader_set_uniform_f(shader_get_uniform(shdPaletteSprite, "paletteLength"), _length);

// create sprite and add its sub-images
var _paletteSprite = noone;
var _num = sprite_get_number(_sprite);
for (var _i = 0; _i < _num; _i++)
{
    draw_clear_alpha(0, 0);
    draw_sprite(_sprite, _i, sprite_get_xoffset(_sprite), sprite_get_yoffset(_sprite));
    
    if (_i == 0)
    {
        _paletteSprite = sprite_create_from_surface(_tempSurface, 0, 0, sprite_get_width(_sprite), sprite_get_height(_sprite),
            0, 0, sprite_get_xoffset(_sprite), sprite_get_yoffset(_sprite));
    }
    else
    {
        sprite_add_from_surface(_paletteSprite, _tempSurface, 0, 0, sprite_get_width(_sprite), sprite_get_height(_sprite),
            0, 0);
    }
}

// cleanup
shader_reset();
surface_reset_target();
surface_free(_tempSurface);

// return
return _paletteSprite;

