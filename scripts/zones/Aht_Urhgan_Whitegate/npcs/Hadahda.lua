-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Hadahda
-- Type: Standard NPC
-- !pos -112.029 -6.999 -66.114 50
-----------------------------------
package.loaded["scripts/zones/Aht_Urhgan_Whitegate/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/Aht_Urhgan_Whitegate/TextIDs");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    player:startEvent(518);
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;

