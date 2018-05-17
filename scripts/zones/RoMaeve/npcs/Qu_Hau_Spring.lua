-----------------------------------
-- Qu_Hau_Spring
-- Area: Ro'Maeve
-----------------------------------
package.loaded["scripts/zones/RoMaeve/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/RoMaeve/TextIDs");
require("scripts/globals/quests");
require("scripts/globals/keyitems");
-----------------------------------

function onTrade(player,npc,trade)
    local DMfirst = player:getQuestStatus(OUTLANDS,DIVINE_MIGHT);
    local DMRepeat = player:getQuestStatus(OUTLANDS,DIVINE_MIGHT_REPEAT);
    local Hour = VanadielHour();

    if ((Hour >= 18 or Hour < 6) and IsMoonFull() == true) then
        if (DMfirst == QUEST_ACCEPTED or DMRepeat == QUEST_ACCEPTED) then -- allow for Ark Pentasphere on both first and repeat quests
            if (trade:hasItemQty(1408,1) and trade:hasItemQty(917,1) and trade:getItemCount() == 2) then
                player:startEvent(7,917,1408); -- Ark Pentasphere Trade
            elseif (DMRepeat == QUEST_ACCEPTED and trade:hasItemQty(1261,1) and trade:getItemCount() == 1 and player:hasKeyItem(dsp.ki.MOONLIGHT_ORE) == false) then
                player:startEvent(8); -- Moonlight Ore trade
            end
        end
    end
end;

function onTrigger(player,npc)
    
	local CurrentMission = player:getCurrentMission(WINDURST);
    local MissionStatus = player:getVar("MissionStatus");

    if (CurrentMission == VAIN and MissionStatus >= 1) then
        player:startEvent(2);
    elseif player:hasKeyItem(dsp.ki.ANCIENT_VERSE_OF_ROMAEVE) then
	    return;
    elseif (CurrentMission == MOON_READING and MissionStatus == 1) then
        player:startEvent(4);
    else
        player:messageSpecial(NOTHING_OUT_OF_ORDINARY);
    end
end;

function onEventUpdate(player,csid,menuchoice)
end;

function onEventFinish(player,csid,option)
    
	if (csid == 4) then
        player:addKeyItem(dsp.ki.ANCIENT_VERSE_OF_ROMAEVE);
		player:messageSpecial(KEYITEM_OBTAINED,dsp.ki.ANCIENT_VERSE_OF_ROMAEVE);

	elseif (csid == 7) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,1550);
        else
            player:addItem(1550);
            player:messageSpecial(ITEM_OBTAINED,1550);
            player:tradeComplete();
        end

    elseif (csid == 8) then
        player:tradeComplete();
        player:addKeyItem(dsp.ki.MOONLIGHT_ORE);
        player:messageSpecial(KEYITEM_OBTAINED,dsp.ki.MOONLIGHT_ORE);

    elseif (csid == 2 and player:getCurrentMission(WINDURST) == VAIN) then
        player:setVar("MissionStatus",2);
    end
end;
