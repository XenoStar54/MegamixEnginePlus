/// roomExternalLoad(filename, [hash])
/// loads a room from an external file and returns its room id, or a negative
/// number if an error occurred.

/// filename: assumed to be relative to the included files directory, and ".room.gmx" extension should be left off.
/// but for external files prepend a + symbol and include the extension

/// if a hash is supplied, the hash is checked and if the level file is corrupted then
/// the file will not be loaded.

/// if room already cached, return that.
if (!is_undefined(global.roomExternalCache[? argument[0]]))
    return global.roomExternalCache[? argument[0]];

// determine actual path to file
var filepath;
if (stringStartsWith(argument[0], "+"))
    filepath = stringSubstring(argument[0], 2);
else
    filepath = argument[0] + ".room.gmx";

// determine file hash
var file_hash = md5FileContents(filepath);
if (is_real(file_hash))
{
    printErr("ERROR LOADING FILE, unable to hash file contents: " + filepath);
    return -5;
}

// enforce file hash (optional)
if (argument_count > 1)
{
    if (file_hash != argument[1])
    {
        printErr("HASH FAILED loading external room: " + filepath);
        printErr("Expected hash: " + argument[1]);
        printErr("Actual hash: " + file_hash);
        return -12;
    }
}

// open file for parsing
var file = file_text_open_read(filepath);
if (file == -1)
    return -1;

var time_parse_begin = get_timer()

// parse properties:
roomExternalParseBegin()
var file_text = ""
while (!file_text_eof(file))
{
     roomExternalParseLine(file_text_readln(file))
}
file_text_close(file);

// external room's id:
var exrm = room_add();

// residual instance properties (must be stored in exgrid below)
var prop_copy, prop_copy_n;
prop_copy[0] = "code";
prop_copy[1] = "scaleX";
prop_copy[2] = "scaleY";
prop_copy[3] = "colour";
prop_copy[4] = "rotation";
prop_copy_n = 5;

// this grid will remain for the length of the game
// it details creation event code for each instance, and also the creation code for the room.
var exgrid = ds_grid_create(ds_list_size(global._roomExternalInstances) + 1, prop_copy_n + 1);
global.roomExternalSetupMap[? exrm] = exgrid;
exgrid[# 0, 0] = xmlStringUnescape(roomExternalParseGetProp("code", ""))

print("Room loaded externally: " + filepath, WL_VERBOSE);
if (argument_count > 1)
    print("Hash confirmed.", WL_VERBOSE);
else
    print("Hash is " + file_hash + " (not enforced!)", WL_VERBOSE);
var time_parse = (get_timer() - time_parse_begin) / 1000
print("Time taken (parse): " + string(time_parse) + " ms", WL_VERBOSE);

// apply properties
room_set_width(exrm, roomExternalParseGetProp("width", 256));
room_set_height(exrm, roomExternalParseGetProp("height", 224));
room_set_background_colour(exrm, roomExternalParseGetProp("colour", c_gray), roomExternalParseGetProp("showColour", true) != 0);

// add backgrounds
for (var i = 0; i < ds_list_size(global._roomExternalBackgrounds); i++)
{
    if (i >= 8 || i < 0)
        return -2;
    var map = global._roomExternalBackgrounds[| i];
    var bgName = map[? "name"];
    var bgID = asset_get_index(bgName);
    if (bgID < 0)
        continue;
    room_set_background(exrm, i,
        real(map[? "visible"]),
        real(map[? "foreground"]),
        bgID,
        real(map[? "x"]),
        real(map[? "y"]),
        real(map[? "htiled"]),
        real(map[? "vtiled"]),
        real(map[? "hspeed"]),
        real(map[? "vspeed"]),
        real(map[? "alpha"]));
}

var customObjectHandler_n = 0
var customObjectHandler_handler = 0
var customObjectHandler_objID = 0
var customObjectHandler_gridIndex = 0
var customObjectHandler_x = 0
var customObjectHandler_y = 0

// add instances
room_instance_add(exrm, 0, 0, objExternalRoomSetup);
for (var i = 0; i < ds_list_size(global._roomExternalInstances); i++)
{
    var map = global._roomExternalInstances[| i];
    var objName = map[? "objName"];
    var objId = asset_get_index(objName);
    if (!object_exists(objId))
    {
        printErr("object asset not found: " + map[? "objName"])
        continue
    }
    var handler = global._roomExternalCustomObjectHandlerMap[? objId]
    var _x = map[? "x"];
    var _y = map[? "y"];
    var inst_id = room_instance_add(exrm, real(_x), real(_y), objId);
    
    if (!is_undefined(handler))
    {
        customObjectHandler_handler[customObjectHandler_n] = handler
        customObjectHandler_gridIndex[customObjectHandler_n] = i + 1
        customObjectHandler_objID[customObjectHandler_n] = objId
        customObjectHandler_x[customObjectHandler_n] = _x
        customObjectHandler_y[customObjectHandler_n] = _y
        customObjectHandler_n++
    }
    
    // copy over additional attributes to the room loader map:
    exgrid[# i + 1, 0] = inst_id;
    for (var j = 0; j < prop_copy_n; ++j)
    {
        var prop = map[? prop_copy[j]]
        if (j == 0 && string_length(prop) > 0) // (creation code needs to be escaped)
        {
            prop = xmlStringUnescape(prop)
        }
        exgrid[# i + 1, j + 1] = prop;
    }
}

// add tiles
for (var i = 0; i < ds_list_size(global._roomExternalTiles); i++)
{
    var map = global._roomExternalTiles[| i];
    var asset = asset_get_index(map[? "bgName"])
    if (background_exists(asset))
    {
        room_tile_add_ext(exrm, asset,
            real(map[? "xo"]), real(map[? "yo"]),
            real(map[? "w"]), real(map[? "h"]),
            real(map[? "x"]), real(map[? "y"]),
            real(map[? "depth"]), real(map[? "scaleX"]), real(map[? "scaleY"]), 1);
    }
    else
    {
        printErr("background asset not found: " + map[? "bgName"])
    }
}

global.roomExternalCache[? argument[0]] = exrm;

// custom object handlers
for (var i = 0; i < customObjectHandler_n; ++i)
{
    var objID = customObjectHandler_objID[i];
    var j = customObjectHandler_gridIndex[i];
    // these are properties the handler can read
    global.roomExternalLoad_handler_roomIndex = exrm
    global.roomExternalLoad_handler_instanceID = exgrid[# j, 0]
    global.roomExternalLoad_handler_creationCode = exgrid[# j, 1]
    global.roomExternalLoad_handler_xscale = exgrid[# j, 2]
    global.roomExternalLoad_handler_yscale = exgrid[# j, 3]
    global.roomExternalLoad_handler_color = exgrid[# j, 4]
    global.roomExternalLoad_handler_rotation = exgrid[# j, 5]
    global.roomExternalLoad_handler_x = customObjectHandler_x[i]
    global.roomExternalLoad_handler_y = customObjectHandler_y[i]
    event_perform_object(objID, ev_other, customObjectHandler_handler[i])
    // handler can edit the creation code:
    exgrid[#j, 1] = global.roomExternalLoad_handler_creationCode
}

roomExternalParseEnd()

var time_total = (get_timer() - time_parse_begin) / 1000
print("Time taken (total): " + string(time_total) + " ms", WL_VERBOSE);

return exrm;
