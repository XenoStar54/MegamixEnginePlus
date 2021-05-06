if (canDamage)
{
    xspeed = cos(degtorad(dir)) * 5;
    yspeed = -sin(degtorad(dir)) * 5 * sign(image_yscale); // The vertical speed was, for some reason, inverted, which is why I used a minus. Don't ask me what actually caused this behaviour
}
var topColl = collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,objTopSolid,true,false);
if ((checkSolid(0, 0) || topColl) && !isBoost)
{
//    var obj = collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,objSolid,true,false);
/*    if (!obj)
    {
        collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,objTopSolid,true,false);
    }*/
    
    
    var doKill = false;
    with (collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,objSolid,true,false))
    {
        if (rectangle_in_rectangle(other.bbox_left,other.bbox_top,other.bbox_right,other.bbox_bottom,bbox_left,bbox_top,bbox_right,bbox_bottom) == 1)
        {
            doKill = true;
        }
    }
    if (!doKill)
    {
        with (topColl)
        {
            if (other.yspeed > 0)
            {
                doKill = true;
            }
        }
    }
    if (!doKill)
    {
        var collList = collisionRectangleList(bbox_left,bbox_right,bbox_top,bbox_bottom,prtEntity,true,true);
        if (!is_real(collList))
        {
            for (var i = 0; i < collList; i++)
            {
                with (ds_list_find_value(collList,i))
                {
                    if (isSolid == 2)
                    {
                        if (other.yspeed > 0)
                        {
                            doKill = true;
                            continue;
                        }
                    }
                    if (isSolid)
                    {
                        if (rectangle_in_rectangle(other.bbox_left,other.bbox_top,other.bbox_right,other.bbox_bottom,bbox_left,bbox_top,bbox_right,bbox_bottom) == 1)
                        {
                            doKill = true;
                            continue;
                        }
                    }
                }
            }
                //printErr("Destroy");
            ds_list_destroy(collList);
            
        }
    }
    
    
    
    
    
    
    //with (instance_place())
    if (doKill && !instance_place(x, y + sign(grav), objLadder))
    {
        instance_destroy();
    }
}
