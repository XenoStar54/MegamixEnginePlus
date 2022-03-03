#define discord_init_dll
/*

Call this script to init the dll files.

Note : This only inits the files , not the rich presence.

Arguments : 
- Noone

Returns:
- Void

-----------------------------------------

Discord Rich Presence for Game Maker made by Aouab

*/

dll = "discord_rich_presence.dll";

if (os_type == os_windows)
{
    global.__d_init = external_define(dll,"InitDiscord",dll_cdecl,ty_real,1,ty_string)
    global.__d_update = external_define(dll,"UpdatePresence",dll_cdecl,ty_real,4,ty_string,ty_string,ty_string,ty_string)
    global.__d_free = external_define(dll,"FreeDiscord",dll_cdecl,ty_real,0)
}


#define discord_init_app
/*

Call this script your discord application.

Note : Call this at the right moment or after calling discord_init_dll()

Arguments : 
1 - Application Id (String)

Returns:
- Boolean (Whether successful)

-----------------------------------------

Discord Rich Presence for Game Maker made by Aouab

*/
if (os_type == os_windows)
{
    return external_call(global.__d_init,argument0)
}


#define discord_update_presence
/*

Call this script to update the presence of your app.

Arguments : 
- State (String)
- Details (String)
- Key of large image (String)
- Key of small image (String)

Returns:
- Void

-----------------------------------------

Discord Rich Presence for Game Maker made by Aouab

*/
if (os_type == os_windows)
{
    external_call(global.__d_update, argument0, argument1, argument2, argument3)
    global.richPresenceSet = true;
}

#define discord_free_app
/*

Call this script to free the application and shut it down corretly.

Warning : It is really important to call this script before game end , otherwise the game will be still displayed on the discord.

Arguments : 
- Noone

Returns:
- Void

-----------------------------------------

Discord Rich Presence for Game Maker made by Aouab

*/

if (os_type == os_windows)
{
    external_call(global.__d_free)
}


#define discord_free_dll
/*

Call this script to free the dll files. (Optional)


Arguments : 
- Noone

Returns:
- Void

-----------------------------------------

Discord Rich Presence for Game Maker made by Aouab

*/

if (os_type == os_windows)
{
    external_free("discord_rich_presence.dll")
}