/// weaponReward(weapon, [absorbOnClear], [firstReward])
// adds the given weapon to the list of rewards for the level
// absorbOnClear - whether the player does the absorb animation when they clear the stage (default: true)

var _obj = argument[0];
var _absorb = true;
var _first = false;
if (argument_count > 1)
{
    _absorb = argument[1];
}

if (_obj != noone)
{
    if (global.weaponLocked[global.weaponID[? _obj]])
    {
        arrayAppendUnique(global.levelReward, _obj);
        setWeaponLocked(_obj, false);
        global.absorbOnClear = global.absorbOnClear || _absorb;
    }
}
