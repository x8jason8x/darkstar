---------------------------------------------------------------------------------------------------
-- func: delquest <logID> <questID> <player>
-- desc: Deletes the given quest from the GM or target player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/quests");

cmdprops =
{
    permission = 4,
    parameters = "sss"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!delquest <logID> <questID> {player}");
end;

function onTrigger(player, logId, questId, target)

    -- validate logId
    local questLog = GetQuestLogInfo(logId);
    if (questLog == nil) then 
        error(player, "Invalid logID.");
        return;
    end
    local logName = questLog.full_name;
    logId = questLog.quest_log;

    -- validate questId
    if (questId ~= nil) then
        questId = tonumber(questId) or _G[string.upper(questId)];
    end
    if (questId == nil or questId < 0) then
        error(player, "Invalid questID.");
        return;
    end

    -- validate target
    local targ;
    if (target == nil) then
        targ = player;
    else
        targ = GetPlayerByName(target);
        if (targ == nil) then
            error(player, string.format("Player named '%s' not found!", target));
            return;
        end
    end

    -- add quest
    targ:delQuest(logId, questId);
    player:PrintToPlayer(string.format("Deleted %s quest %i from %s.", logName, questId, targ:getName()));

end;