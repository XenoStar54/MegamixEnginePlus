/// setScreenSize(screenSize, [shift])
// argument0: screen size
// argument1: shift screen to centre? default: true

// setScreenSize(screenSize, [shift])
// argument0: screen size
// argument1: shift screen to centre? default: true

var ns = argument[0];
var shift = true;
if (argument_count > 1)
{
    shift = argument[1];
}
var xsize = global.screenWidth;
var ysize = global.screenHeight;
var full = 0;

var s = max(1, min(ns, round(display_get_height() / ysize), round(display_get_width() / xsize)));

// change screen size
s = round(s);

xsize *= s;
ysize *= s;

xsize *= getPixelRatio();

window_set_size(xsize, ysize);

if (!window_get_fullscreen() && shift)
{
    window_set_position(
        round((display_get_width() - xsize) / 2),
        round((display_get_height() - ysize) / 2));
}

global.screenSize = s;

// size 1 & 2 downscales the crt effect too much, which only looks right
// when the crt surface is at specific scales
if ((!window_get_fullscreen() && global.screenSize == 1) || global.resolution)
{
    global.crtSurfaceScale = 2;
}
else if (!window_get_fullscreen() && global.screenSize == 2)
{
    global.crtSurfaceScale = 4;
}
else
{
    global.crtSurfaceScale = 6;
}

// change surface size
if (!global.resolution)
{
    global.screenScale = 1;
}
else
{
    // note: might cause lag when applying full-screen shaders
    global.screenScale = global.screenSize;
    if (window_get_fullscreen())
    {
        if (global.accurateFullscreen)
        {
            global.screenScale = max(1, min(round(display_get_height() / global.screenHeight), round(display_get_width() / global.screenWidth)));
        }
        else
        {
            global.screenScale = max(1, min(display_get_height() / global.screenHeight, display_get_width() / global.screenWidth));
        }
    }
    
    global.screenScale = min(global.screenScale, global.screenScaleMax);
}

surface_resize(application_surface, round(global.screenWidth * global.screenScale), round(global.screenHeight * global.screenScale));

global.crtSurfaceWidth = round(global.screenWidth * global.screenScale * global.crtSurfaceScale);
global.crtSurfaceHeight = round(global.screenHeight * global.screenScale * global.crtSurfaceScale);
