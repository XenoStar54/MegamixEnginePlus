/// playerHandlePausing();
// Pausing
if (!playerIsLocked(PL_LOCK_PAUSE))
{
    if (!instance_exists(objPauseMenu))
    {
        if (global.keyPausePressed[playerID])
        {
            if (global.playerHealth[playerID] > 0)
            {
                queuePause(true);
                global.createArgument[0] = playerID;
                switch global.pauseMenu{
                    case 0:
                        instance_create(x, y, objOldPauseMenu);
                        break;
                    default:
                    case 1:
                        instance_create(x, y, objNewPauseMenu);
                        break;
                }
                playSFX(sfxPause);
            }
        }
    }
}
