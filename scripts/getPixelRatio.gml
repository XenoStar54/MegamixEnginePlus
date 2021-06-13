/// getPixelRatio()
// returns the value to mulltiply the screen width by to achieve the current pixel ratio setting
switch (global.pixelRatio)
{
    default:
    case 0: return 1;
    case 1: return 8/7;
    case 2: return 4/3;
}
