/// awardAchievement(achievementInternalName)
// appends argument0 into the achievement tracker array if it doesn't have it yet
// then spawns an achievement get popup

var success = false;

if(global.achievementsAreSaveFileBound)
{
    if(!indexOf(global.achievementTrackerSave,argument0))
    {
        success = true;
        arrayAppendUnique(global.achievementTrackerSave,argument0);
    }
}
else
{
    if(!indexOf(global.achievementTrackerIndependent,argument0))
    {
        success = true;
        arrayAppendUnique(global.achievementTrackerIndependent,argument0);
    }
}

if(success)
{
    instance_create(view_xview,view_yview,objAchievementGetPopup);
    saveLoadAchievements(1);
}
