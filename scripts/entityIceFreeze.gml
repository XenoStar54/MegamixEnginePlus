/// entityIceFreeze(time, [physics], [solid], [graphics], [canDamage?])
/// freezes this entity (as though by ice)
// time: minimum time to freeze for
// physics [default: true]: true/false -- should object fall while frozen, etc.?
// solid [default: false]: should object be solid while frozen
// graphics [default: 0]: graphics style (currently only 0 -- light blue frozen)
// canDamage [default: canDamage]: whether the entity can damage things while frozen

var time = argument[0];
var _physics = true;
var _solid = false;
var _graphics = 0;
var _canDamage = canDamage;

if (argument_count > 1)
{
    _physics = argument[1];
}

if (argument_count > 2)
{
    _solid = argument[2];
}

if (argument_count > 3)
{
    _graphics = argument[3];
}

if (argument_count > 4)
{
    _canDamage = argument[4];
}

if (time <= 0)
{
    exit;
}

if (!canIce)
{
    exit;
}

// if not currently iced...
if (iceTimer == 0)
{
    speedPreIce = speed;
    yspeedPreIce = yspeed;
    xspeedPreIce = xspeed;
    gravPreIce = grav;
    solidPreIce = isSolid;
    canDamagePreIce = canDamage;
    blockCollisionPreIce = blockCollision;
    imageSpeedPreIce = image_speed;
    icePhysics = _physics;
    iceSolid = _solid;
    iceGraphicStyle = _graphics;
    iceCanDamage = _canDamage;
    doesTransitionPreIce = doesTransition;
}

// set ice timer
iceTimer = max(iceTimer, time);
