-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Balasiel
-- Starts and Finishes: A Squire's Test, A Squire's Test II, A Knight's Test
-- @zone 230
-- !pos -136 -11 64
-------------------------------------
package.loaded["scripts/zones/Southern_San_dOria/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/Southern_San_dOria/TextIDs");
require("scripts/globals/keyitems");
require("scripts/globals/settings");
require("scripts/globals/quests");
require("scripts/globals/status");
require("scripts/globals/titles");
-----------------------------------

function onTrade(player,npc,trade)

    if (trade:getItemCount() == 1) and (trade:hasItemQty(16892,1)) then -- check trial pole latent points
	    if trade:getItem(0):getWeaponskillPoints() >= 100 then --(retail is 300)
	        player:startEvent(9); -- enough points
		else
		    player:startEvent(10); -- not enough points
		end

	elseif (player:getQuestStatus(SANDORIA,A_SQUIRE_S_TEST) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(940,1) and trade:getItemCount() == 1) then
            player:startEvent(617);
        end
    end
end;

function onTrigger(player,npc)

    local LvL = player:getMainLvl();
    local ASquiresTest = player:getQuestStatus(SANDORIA, A_SQUIRE_S_TEST);
    local ASquiresTestII = player:getQuestStatus(SANDORIA,A_SQUIRE_S_TEST_II);
    local AKnightsTest = player:getQuestStatus(SANDORIA, A_KNIGHT_S_TEST);
	local methodMad = player:getQuestStatus(SANDORIA,METHODS_CREATE_MADNESS); -- Polearm WSNM quest
    local polSkill = player:getSkillLevel(dsp.skill.POLEARM);

    if (methodMad == QUEST_AVAILABLE and LvL >= WSNM_LEVEL and polSkill >= 240) then -- WSNM quest
	    if player:hasKeyItem(343) or player:hasKeyItem(344) or player:hasKeyItem (345) then
		    return; -- preempts player from getting quest if another wsnm is active
		else
		    player:startEvent(8); -- start Methods Create Madness (Impulse Drive wsnm quest)
		end
	elseif (methodMad == QUEST_ACCEPTED) then
		if player:hasKeyItem(345) then 
            player:startEvent(13); -- player has Annals of Truth
		elseif player:hasKeyItem(344) then
		    player:startEvent(12); -- player has Map to Annals
        else			
		    player:startEvent(11); -- dropped pole or quit quest options
		end

    elseif (player:getQuestStatus(SANDORIA,KNIGHT_STALKER) == QUEST_ACCEPTED and player:getVar("KnightStalker_Progress") == 2) then
        player:startEvent(63); -- DRG AF3 cutscene, doesn't appear to have a follow up.
    elseif (LvL < 7) then
        player:startEvent(668);
    elseif (LvL >= 7 and ASquiresTest ~= QUEST_COMPLETED) then
        if (ASquiresTest == 0) then
            if (player:getVar("SquiresTest") == 1) then
                player:startEvent(631);
            else
                player:startEvent(616);
            end
        elseif (ASquiresTest == QUEST_ACCEPTED) then
            player:startEvent(667);
        end
    elseif (LvL >= 7 and LvL < 15) then
        player:startEvent(671);
    elseif (LvL >= 15 and ASquiresTestII ~= QUEST_COMPLETED) then
        local StalactiteDew = player:hasKeyItem(dsp.ki.STALACTITE_DEW)

        if (ASquiresTestII == QUEST_AVAILABLE) then
            player:startEvent(625);
        elseif (ASquiresTestII == QUEST_ACCEPTED and StalactiteDew == false) then
            player:startEvent(630);
        elseif (StalactiteDew) then
            player:startEvent(626);
        else
            player:startEvent(667);
        end
    elseif (LvL >= 15 and LvL < 30) then
        player:startEvent(670);
    elseif (LvL >= 30 and AKnightsTest ~= QUEST_COMPLETED) then
        if (AKnightsTest == 0) then
            if (player:getVar("KnightsTest_Event") == 1) then
                player:startEvent(635);
            else
                player:startEvent(627);
            end
        elseif (player:hasKeyItem(dsp.ki.KNIGHTS_SOUL)) then
            player:startEvent(628);
        else
            player:startEvent(669);
        end
    else
        player:startEvent(667);
    end
end;

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);

    if (csid == 8 and option == 1) then
	    if (player:getFreeSlotsCount() < 1) then
            player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,16892);
	    else
	        player:addQuest(SANDORIA,METHODS_CREATE_MADNESS); -- start wsnm quest
			player:addItem(16892);
	        player:messageSpecial(ITEM_OBTAINED,16892);
		    player:addKeyItem(343);
	        player:messageSpecial(KEYITEM_OBTAINED,343);
        end
	elseif (csid == 11) then
	    if (option == 1) then -- lost/dropped pole of trials
		    if (player:getFreeSlotsCount() < 1 or player:hasItem(16892)) then
                player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,16892);
		    else	
		        player:addItem(16892);
			    player:messageSpecial(ITEM_OBTAINED,16892);
			end
		elseif (option == 2) then -- quit wsnm quest
		    player:delQuest(SANDORIA,METHODS_CREATE_MADNESS);
			player:delKeyItem(343);
	    end
	elseif (csid == 9) then  -- attain Map to Annals
	    player:tradeComplete();
	    player:delKeyItem(343);
	    player:addKeyItem(344);
		player:messageSpecial(KEYITEM_OBTAINED,344);
	elseif (csid == 13) then -- Methods Create Madness end
		player:delKeyItem(345);
		player:addLearnedWeaponskill(8);
		player:messageSpecial(IMPULSE_DRIVE_LEARNED);
		player:addFame(SANDORIA,250); -- no idea on retail value, using 250 as default
		player:completeQuest(SANDORIA,METHODS_CREATE_MADNESS);

	elseif (csid == 616) then
        if (option == 0) then
            player:addQuest(SANDORIA,A_SQUIRE_S_TEST);
        else
            player:setVar("SquiresTest_Event",1);
        end
    elseif (csid == 631 and option == 0) then
        player:addQuest(SANDORIA,A_SQUIRE_S_TEST);
        player:setVar("SquiresTest_Event",0);
    elseif (csid == 617) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:tradeComplete();
            player:addTitle(dsp.title.KNIGHT_IN_TRAINING);
            player:addItem(16565);
            player:messageSpecial(ITEM_OBTAINED, 16565); -- Spatha
            player:addFame(SANDORIA,30);
            player:completeQuest(SANDORIA,A_SQUIRE_S_TEST);
        else
           player:messageSpecial(ITEM_CANNOT_BE_OBTAINED, 16565); -- Spatha
        end
    elseif (csid == 625 or csid == 630) then
        player:addQuest(SANDORIA,A_SQUIRE_S_TEST_II);
    elseif (csid == 626) then
        player:tradeComplete();
        player:addTitle(dsp.title.SPELUNKER);
        player:delKeyItem(dsp.ki.STALACTITE_DEW);
        player:addKeyItem(dsp.ki.SQUIRE_CERTIFICATE);
        player:messageSpecial(KEYITEM_OBTAINED, dsp.ki.SQUIRE_CERTIFICATE);
        player:addFame(SANDORIA,30);
        player:completeQuest(SANDORIA,A_SQUIRE_S_TEST_II);
    elseif (csid == 627) then
        if (option == 0) then
            player:addQuest(SANDORIA,A_KNIGHT_S_TEST);
            player:addKeyItem(dsp.ki.BOOK_OF_TASKS);
            player:messageSpecial(KEYITEM_OBTAINED, dsp.ki.BOOK_OF_TASKS);
        else
            player:setVar("KnightsTest_Event",1);
        end
    elseif (csid == 635 and option == 0) then
        player:addQuest(SANDORIA,A_KNIGHT_S_TEST);
        player:addKeyItem(dsp.ki.BOOK_OF_TASKS);
        player:messageSpecial(KEYITEM_OBTAINED, dsp.ki.BOOK_OF_TASKS);
        player:setVar("KnightsTest_Event",0);
    elseif (csid == 628) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:addTitle(dsp.title.TRIED_AND_TESTED_KNIGHT);
            player:delKeyItem(dsp.ki.KNIGHTS_SOUL);
            player:delKeyItem(dsp.ki.BOOK_OF_TASKS);
            player:delKeyItem(dsp.ki.BOOK_OF_THE_WEST);
            player:delKeyItem(dsp.ki.BOOK_OF_THE_EAST);
            player:addItem(12306);
            player:messageSpecial(ITEM_OBTAINED, 12306); -- Kite Shield
            player:unlockJob(dsp.job.PLD);
            player:messageSpecial(UNLOCK_PALADIN);
            player:addFame(SANDORIA,30);
            player:completeQuest(SANDORIA,A_KNIGHT_S_TEST);
        else
           player:messageSpecial(ITEM_CANNOT_BE_OBTAINED, 12306); -- Kite Shield
        end
    elseif (csid == 63) then
        player:setVar("KnightStalker_Progress",3);
    end
end;
