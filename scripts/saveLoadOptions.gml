/// saveLoadOptions(save?);
// saves / loads options
// save? -- true: save; false: load

slBegin(argument0, "options.sav")

// option flags
global.screenSize            = sl(global.screenSize,   "screensize");
setFullscreen(sl(window_get_fullscreen(), "fullscreen"));
global.resolution            = sl(global.resolution, "resolution");
global.pixelRatio            = sl(global.pixelRatio, "pixel-ratio");
global.accurateFullscreen    = sl(global.accurateFullscreen, "accurate-fullscreen");
global.shadersEnabled        = sl(global.shadersEnabled, "shadersenabled") && global.shadersCompatible;
global.enforcePalette        = sl(global.enforcePalette, "enforce-palette");
global.filter                = sl(global.filter, "filter");
global.crtDistort            = sl(global.crtDistort, "crt-distort");
global.crtDistortionAmount   = sl(global.crtDistortionAmount, "crt-distortion-amount");
global.crtBorder             = sl(global.crtBorder, "crt-border");
global.borderGraphic         = sl(global.borderGraphic, "border-graphic");
global.musicvolume           = sl(global.musicvolume,  "mvol");
global.soundvolume           = sl(global.soundvolume,  "svol");
global.damagePopup           = sl(global.damagePopup,  "dpop");
global.mmColor               = sl(global.mmColor,      "mmcol");
global.chargeBar             = sl(global.chargeBar,    "cbar");
global.lifeCounter           = sl(global.lifeCounter, "lives-counter");
global.showFPS               = sl(global.showFPS,      "fps");
global.healthEffect          = sl(global.healthEffect, "healthfx");
global.playerCount           = sl(global.playerCount,  "player-count");
global.healthEffect          = sl(global.healthEffect,   "healthfx");
global.playerCount           = sl(global.playerCount,    "player-count");
playerGlobalInit(); // Initialize global variable arrays for all players.
global.pickupGraphics        = sl(global.pickupGraphics, "item-graphics");
global.deathEffect           = sl(global.deathEffect, "death-effect");
global.jumpSound             = sl(global.jumpSound, "jump-sound");
global.teleportSound         = sl(global.teleportSound, "teleport-sound");
global.checkpointNotification= sl(global.checkpointNotification, "checkpoint-notice");
global.vsync                 = sl(global.vsync,          "vsync");
global.showControllerOverlay = sl(global.showControllerOverlay, "controlleroverlay");
global.escapeBehavior        = sl(global.escapeBehavior, "escapebehavior");

// controls
for (var i = 0; i < global.maxPlayerCount; i += 1)
{
    // keyboard
    global.leftKey[i]  = sl(global.leftKey[i],  "key-l" + string(i));
    global.rightKey[i] = sl(global.rightKey[i], "key-r" + string(i));
    global.upKey[i]    = sl(global.upKey[i],    "key-u" + string(i));
    global.downKey[i]  = sl(global.downKey[i],  "key-d" + string(i));
    global.jumpKey[i]  = sl(global.jumpKey[i],  "key-j" + string(i));
    global.shootKey[i] = sl(global.shootKey[i], "key-x" + string(i));
    global.slideKey[i] = sl(global.slideKey[i], "key-s" + string(i));
    global.pauseKey[i] = sl(global.pauseKey[i], "key-pause" + string(i));
    global.weaponSwitchLeftKey[i]  = sl(global.weaponSwitchLeftKey[i],  "key-swl" + string(i));
    global.weaponSwitchRightKey[i] = sl(global.weaponSwitchRightKey[i], "key-swr" + string(i));
    global.weaponWheelKey[i] = sl(global.weaponWheelKey[i], "key-ww" + string(i));
    
    // joystick
    global.joystick_jumpKey[i]  = sl(global.joystick_jumpKey[i],  "joy-j" + string(i));
    global.joystick_shootKey[i] = sl(global.joystick_shootKey[i], "joy-x" + string(i));
    global.joystick_slideKey[i] = sl(global.joystick_slideKey[i], "joy-s" + string(i));
    global.joystick_pauseKey[i] = sl(global.joystick_pauseKey[i], "joy-pause" + string(i));
    global.joystick_weaponSwitchLeftKey[i]  = sl(global.joystick_weaponSwitchLeftKey[i],  "joy-swl" + string(i));
    global.joystick_weaponSwitchRightKey[i] = sl(global.joystick_weaponSwitchRightKey[i], "joy-swr" + string(i));
    global.joystick_weaponWheelKey[i] = sl(global.joystick_weaponWheelKey[i], "joy-ww" + string(i));
}

for(var j = 0; j < 4; j++) for(var i = 0; i < array_height_2d(global.weaponWheelSavedWeapon); i++) global.weaponWheelSavedWeapon[i,j] = sl(global.weaponWheelSavedWeapon[i,j], "ww" + string(i) + "pl" + string(j));

slEnd();

//@noformat
