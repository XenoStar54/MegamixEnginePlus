/// specialDamageValue(type, damage);
// This script checks the object_index of the "other" instance
// to determine a new value for "global.damage"

// type: either an object index, string name of object, or a string category (see below)
// damage: how much damage to do.

var type = argument0;
var newDamage = argument1;

// Basic, by-object
if (!is_string(type))
{
    if (other.object_index == type)
    {
        global.damage = newDamage;
    }
}
else // Based on the category of the enemy (or by string reference of object name)
{
    if (object_get_name(other.object_index) == type || hasCategory(other.category, type))
    {
        global.damage = newDamage;
    }
}
