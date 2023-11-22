/// railCollision(doRailCollision);
// used to correct the rail platform within the rails

var _doRailCollision = argument0;

var prevMask = mask_index;
mask_index = sprDot;
var xpos = x + xOffset;
var ypos = y + yOffset;
var mvx = xspeed;
var mvy = yspeed;
// var touchRail = collision_rectangle(round(xpos) - 2, round(ypos) - 2, round(xpos) + 2, round(ypos) + 2, prtRail, 1, 1);

if(_doRailCollision && instance_exists(lastRail))
{
    if(place_meeting(xpos,ypos,lastRail)) // unstuck
    {
        // test for freeing the platform hook
        if(!place_meeting(xpos+1,ypos,lastRail))
        {
            shiftObject(1,0,0);
        }
        else if(!place_meeting(xpos-1,ypos,lastRail))
        {
            shiftObject(-1,0,0);
        }
        else if(!place_meeting(xpos,ypos+1,lastRail))
        {
            shiftObject(0,1,0);
        }
        else if(!place_meeting(xpos,ypos-1,lastRail))
        {
            shiftObject(0,-1,0);
        }
        else if(!place_meeting(xpos+1,ypos+1,lastRail))
        {
            shiftObject(1,1,0);
        }
        else if(!place_meeting(xpos-1,ypos+1,lastRail))
        {
            shiftObject(-1,1,0);
        }
        else if(!place_meeting(xpos+1,ypos-1,lastRail))
        {
            shiftObject(1,-1,0);
        }
        else if(!place_meeting(xpos-1,ypos-1,lastRail))
        {
            shiftObject(-1,-1,0);
        }
    }
    
    // does this work?
    with(prtRail)
    {
        solid = 1;
    }
    // perform steps forward
    var stepCount = 4;
    for(var i = 0; i < stepCount; i++)
    {
        x += mvx/stepCount;
        y += mvy/stepCount;
    }
    /*
    // move 
    x += mvx;
    y += mvy;
    */
    /*
    while(mvx != 0 || mvy != 0) // inch forward
    {
        var submvx = sign(xspeed)*min(abs(mvx),1);
        var submvy = sign(yspeed)*min(abs(mvy),1);
        x += submvx;
        mvx -= submvx;
        y += submvy;
        mvy -= submvy;
        xpos = x + xOffset;
        ypos = y + yOffset;
    }
    */
    with(prtRail)
    {
        solid = 0;
    }
}
else
{
    // move
    x += mvx;
    y += mvy;
}

mask_index = prevMask;
