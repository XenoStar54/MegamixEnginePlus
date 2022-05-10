/// ySpeedAim(originY, targetY, [accel], [speedLimit])
/* This script does something different than xSpeedAim. It returns a speed set to the value needed to exactly reach a
certain height with the given values */

// argument0 - y position to aim from
// argument1 - y position to reach
// argument2 - accel (default is the calling object's grav variable)
// argument3 - cap for how fast a value this script can return (optional) (set it to -1 to have no speed limit)

var _originY = argument[0];
var _targetY = argument[1];
var _accel = 0;
var _speedLimit = 10; // default speed limit


if (argument_count > 2)
{
    _accel = argument[2];
}
else
{
    _accel = grav;
}

if (argument_count > 3)
{
    _speedLimit = argument[3];
}

// save direction we're going so it can be applied after square rooting
var _dir = 0;
if (_accel > 0)
{
    _dir = -1;
}
else
{
    _dir = 1;
}

// if what we're going is behind where we're jumping at, then jump a default height
if ((_dir < 0 && _targetY > _originY) || (_dir > 0 && _targetY < _originY))
{
    _targetY = _originY + 24 * _dir;
}

// calculate
_accel = abs(_accel);

var _substitution = 2 * _accel * abs(_targetY - _originY);

if (_substitution <= 0)
{
    // if nonsense, than quit
    return 0;
}

var _newYSpeed = sqrt(_substitution) * _dir;

// enforce speed limit
if (_speedLimit >= 0 && _newYSpeed != 0 && abs(_newYSpeed) > _speedLimit)
{
    _newYSpeed = _speedLimit * sign(_newYSpeed);
}

return _newYSpeed;
