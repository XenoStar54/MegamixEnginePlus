/// saveLoadAchievements(save?)

if(global.achievementsAreSaveFileBound) // just saves the game
{
    saveLoadGame(argument0);
}
else // makes or writes into achievements.sav
{
    slBegin(argument0, "achievements.sav");
    global.achievementTrackerIndependent = sl(global.achievementTrackerIndependent, 'achievements', 1);
    slEnd();
}
