/// playSFX(index, [loops?], [gain])
// Plays a sound effect

_index = argument[0]
_loops = false;
_gain = 1;

if (argument_count >= 2)
{
    _loops = argument[1];
}

if (argument_count >= 3)
{
    _gain = argument[2];
}

return playSFXExt(_index, 50, _loops, _gain);

