-----------------------------------
-- History WS unlocker (Katana)
-----------------------------------

require("scripts/globals/settings");
package.loaded["scripts/zones/Celennia_Memorial_Library/TextIDs"] = nil;
require("scripts/zones/Celennia_Memorial_Library/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)

    if (trade:getItemCount() == 1) and (trade:hasItemQty(18983,1)) then
	    if (player:getFreeSlotsCount() < 1) then
            player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,19003);
		else
			player:tradeComplete();
		    player:addItem(19003,1,44,4,45,9,515,9); -- augged mythic
		    player:messageSpecial(ITEM_OBTAINED,19003);
		end
	elseif (trade:getItemCount() == 1) and (trade:hasItemQty(19861,1)) then
	    player:tradeComplete();
		player:addLearnedWeaponskill(43);
		player:PrintToPlayer("You have learned the weaponskill 'Blade: Hi'!", 0xD);
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
    local mLvl = player:getMainLvl();
	local katSkill = player:getSkillLevel(dsp.skill.KATANA);

    if katSkill < 291 or player:hasLearnedWeaponskill(25) then
        player:PrintToPlayer("History: I have weaponskills or a Katana, if you have the requisite level or item trade...", 0xD);
    elseif mLvl == 75 and katSkill > 291 and player:hasLearnedWeaponskill(9) then
	    player:addLearnedWeaponskill(25);
		player:PrintToPlayer("You have learned the weaponskill 'Blade: Kamu'!", 0xD);
	end
end;

-----------------------------------
-- onEventUpdate Action
-----------------------------------

function onEventUpdate(player,csid,option)
--print("onEventUpdate");
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish Action
-----------------------------------

function onEventFinish(player,csid,option)
--print("onEventFinish");
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;
