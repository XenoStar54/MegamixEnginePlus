/// gainSFX(sound_index, [gain])
var _si = argument[0];
var _gain = 1;
if (argument_count > 1)
{
    _gain = argument[1];
}

if (global.unboundedMusicVolume == -1)
{
    audio_sound_gain(_si, global.soundvolume * _gain * 0.01, 0);
}
else
{
    audio_sound_gain(_si, (global.soundvolume * _gain * 0.01) / global.unboundedMusicVolume, 0);
}
