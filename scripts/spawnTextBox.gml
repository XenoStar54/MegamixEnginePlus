// spawnTextBox(screenTop, endEvent, name, name color, text)
// argument0: 0 at the top; 1 in the middel; 2 at the bottom
// argument1: what event 'event_user(x)' it triggers after closing it. If it's -1, it defaults to just freeing MM.
// argument2: name;
// argument3: name color;
// argument4-15: the text that should be displayed, place after the last argument you need a -1

// spawn textbox
var _i = instance_create(x, y, objDialogueBox);
if ((object_index == objNPC || object_is_ancestor(object_index, objNPC)) && npcID != 0)
{
    _i.parent = npcID;
}

_i.pos = argument[0];
_i.origin = id;
_i.o_event = argument[1];
_i.name = argument[2];
_i.nameCol = argument[3];

// insert text
for (var ca = 4; ca <= 15 && ca < argument_count; ca += 1)
{
    if (!is_string(argument[ca]))
    {
        return _i;
    }
    
    ds_list_add(_i.text, argument[ca]);
}

return _i;
