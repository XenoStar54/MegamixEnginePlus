///drawPauseMenuWeapon(Weapon ID, Weapon Slot X, Weapon Slot Y, Icon X, Icon Y, Bar X, Bar Y, Name X, Name Y, Health Bar?)

    var weapID = argument0
    var weapX = argument1
    var weapY = argument2
    var iconX = argument3
    var iconY = argument4
    var barX = argument5
    var barY = argument6
    var nameX = argument7
    var nameY = argument8
    var lifebar = argument9
    
    var pColP, pColS, rColP, rColS;
    switch(costumeID){
        default:
            pColP = global.nesPalette[14];
            pColS = global.nesPalette[27];
            rColP = global.nesPalette[19];
            rColS = global.nesPalette[40];
        break;
    }
    
    var col;
    /*col[0, 0] = global.nesPalette[0];
    col[1, 0] = global.nesPalette[13];
    col[0, 1] = global.primaryCol[0];
    col[1, 1] = global.secondaryCol[0];
    col[0, 2] = make_color_rgb(255, 228, 164);
    col[1, 2] = c_white;*/
    
    col[0] = make_color_rgb(255, 228, 164);
    col[1] = global.primaryCol[global.weaponID[? weapID]];
    col[2] = global.secondaryCol[global.weaponID[? weapID]];
    col[3] = c_white;
    
    textCol[0] = global.nesPalette[0]
    textCol[1] = c_white
    
    //Row 0
    if global.weaponLocked[weaponSlot[weapX,weapY]] < 2 && weaponSlot[weapX,weapY] <= global.totalWeapons - 1
    {
    if weaponX == weapX && weaponY == weapY && pauseRow == 0
    {    
        draw_set_halign(fa_left);
        if phase != 6
        {
        draw_sprite_ext(global.weaponIcon[weapID], 0, x + iconX, y + iconY, 1, 1, 0, c_white, 1);
        draw_sprite_ext(global.weaponIcon[weapID], 1, x + iconX, y + iconY, 1, 1, 0, col[1], 1);
        draw_sprite_ext(global.weaponIcon[weapID], 2, x + iconX, y + iconY, 1, 1, 0, col[2], 1);    
        draw_sprite_ext(global.weaponIcon[weapID], 3, x + iconX, y + iconY, 1, 1, 0, col[3], 1);
        }
        else draw_sprite(sprWTank, 0, x + iconX, y + iconY)
        
        wname = global.weaponName[weapID];
        dot = string_pos(" ", wname);
        if (dot)
        {
            wname = string_insert(".", string_delete(wname, 2, dot - 1), 2);
        }    
        if string_length(wname) > 7
        {
            draw_text(x + nameX, y + nameY, string_copy(wname, 1, 7));   
        }
        else
        {
            draw_text(x + nameX, y + nameY, wname);   
        }
        
        if !global.weaponLocked[weaponSlot[weapX,weapY]]
        {
            draw_sprite_ext(sprPauseMenuBarPrimary, global.ammo[playerID, weapID], x + barX, y + barY, 1, 1, 0, col[1], 1);
            draw_sprite_ext(sprPauseMenuBarSecondary, global.ammo[playerID, weapID], x + barX, y + barY, 1, 1, 0, col[2], 1);   
        }
        else
        {
            draw_sprite_ext(sprPauseMenuDisabled, 0, x + barX, y + barY, 1, 1, 0, c_white, 1); 
            draw_sprite_ext(sprPauseMenuDisabled, 1, x + barX, y + barY, 1, 1, 0, col[1], 1); 
            draw_sprite_ext(sprPauseMenuDisabled, 2, x + barX, y + barY, 1, 1, 0, col[1], 1); 
        }
    }
    else
    {    
        draw_set_halign(fa_left);
        draw_sprite_ext(global.weaponIcon[weapID], 0, x + iconX, y + iconY, 1, 1, 0, c_white, 1);
        draw_sprite_ext(global.weaponIcon[weapID], 1, x + iconX, y + iconY, 1, 1, 0, global.nesPalette[0], 1);
        draw_sprite_ext(global.weaponIcon[weapID], 2, x + iconX, y + iconY, 1, 1, 0, global.nesPalette[13], 1);    
        draw_sprite_ext(global.weaponIcon[weapID], 3, x + iconX, y + iconY, 1, 1, 0, col[3], 1);
        
        wname = global.weaponName[weapID];
        dot = string_pos(" ", wname);
        if (dot)
        {
            wname = string_insert(".", string_delete(wname, 2, dot - 1), 2);
        } 
          
        if string_length(wname) > 7
        {
            draw_text(x + nameX, y + nameY, string_copy(wname, 1, 7));   
        }
        else
        {
            draw_text(x + nameX, y + nameY, wname);   
        }
        
        if !global.weaponLocked[weaponSlot[weapX,weapY]]
        {
            draw_sprite_ext(sprPauseMenuBarPrimary, global.ammo[playerID, weapID], x + barX, y + barY, 1, 1, 0, global.nesPalette[0], 1);
            draw_sprite_ext(sprPauseMenuBarSecondary, global.ammo[playerID, weapID], x + barX, y + barY, 1, 1, 0, global.nesPalette[13], 1);
        }
        else
        {
            draw_sprite_ext(sprPauseMenuDisabled, 0, x + barX, y + barY, 1, 1, 0, c_white, 1); 
        }    
    }
    }
    else
    {   
        draw_set_halign(fa_left);
        draw_text(x + nameX, y + nameY, "???????");
        draw_sprite_ext(sprWeaponIconsPlaceholder, weaponX == weapX && weaponY == weapY && pauseRow == 0, x + iconX, y + iconY, 1, 1, 0, c_white, 1);
    }
