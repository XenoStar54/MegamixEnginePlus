/// playSFXExt(index, priority, loops?, gain)
// Plays a sound effect

_index = argument[0]
_priority = argument[1];
_loops = argument[2];
_gain = argument[3];

audio_stop_sound(_index);

var mySound = audio_play_sound(_index, _priority, _loops);
gainSFX(mySound, _gain);

return mySound;

