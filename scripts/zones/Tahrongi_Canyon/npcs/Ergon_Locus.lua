-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Ergon Locus
-----------------------------------
package.loaded["scripts/zones/Tahrongi_Canyon/TextIDs"] = nil
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/zones/Tahrongi_Canyon/TextIDs")
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)

    local pNation = player:getNation()
    local danceLuopans = player:getQuestStatus(ADOULIN,DANCES_WITH_LUOPANS)

    if (player:hasKeyItem(dsp.ki.FISTFUL_OF_HOMELAND_SOIL) == false and pNation == dsp.nation.WINDURST and
        danceLuopans == QUEST_ACCEPTED) then
        player:addKeyItem(dsp.ki.FISTFUL_OF_HOMELAND_SOIL)
        player:messageSpecial(KEYITEM_OBTAINED,dsp.ki.FISTFUL_OF_HOMELAND_SOIL)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end
