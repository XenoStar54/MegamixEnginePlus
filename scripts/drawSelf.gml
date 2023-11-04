/// drawSelf([use offsets?])
//draw_self();

var useOffsets = 0;
if(argument_count > 0) useOffsets = argument[0];
var _x = (floor((x * global.screenScale) + .5) / global.screenScale);
var _y = (floor((y * global.screenScale) + .5) / global.screenScale);
if(useOffsets)
    draw_sprite_ext(sprite_index,image_index,_x+drawOffsetX,_y+drawOffsetY,
    image_xscale,image_yscale,image_angle,image_blend,image_alpha);
else
    draw_sprite_ext(sprite_index,image_index,_x,_y,
    image_xscale,image_yscale,image_angle,image_blend,image_alpha);
