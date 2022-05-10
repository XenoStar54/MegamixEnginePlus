/// scrBusterControl([canCharge?], [canAim?], [canStartShoot?], [busterSFX])
/* setting canStartShoot to false makes you unable to start charging or shoot small pellets,
    but it lets you release charge shots currently being charged. Useful for stuff like utilities */
    
var _charge = true;
if (argument_count > 0)
{
    _charge = argument[0];
}

var _aim = true;
if (argument_count > 1)
{
    _aim = argument[1];
}

var _startShoot = true;
if (argument_count > 2)
{   
    _startShoot = argument[2];
}

var _sfx = sfxBuster;
if (argument_count > 3)
{   
    _sfx = argument[3];
}

if (object_index == objNormalBusterShot)
{
    // normal shots
    scrBusterDefault_14();
}
else 
{
    switch (global.characterSelected[playerID])
    {
        default: // All characters besides Bass and Proto Man use the same event
        case "Mega Man":
        case "Roll":
        {
            scrBusterDefault_14(_charge, _startShoot, _sfx);
            break;
        }
        
        case "Proto Man":
        {
            scrBusterProto_14(_charge, _startShoot, _sfx);
            break;
        }
        
        case "Bass":
        {
            scrBusterBass_14(_aim, _startShoot, _sfx);
            break;
        }
    }
}
