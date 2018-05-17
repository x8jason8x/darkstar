-----------------------------------
-- Area: Port Bastok
--  NPC: Ilita
-- Linkshell merchant
--   !pos -142 -1 -25 236
-- Confirmed shop stock, August 2013
-----------------------------------
package.loaded["scripts/zones/Port_Bastok/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/shop");
require("scripts/zones/Port_Bastok/TextIDs");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    player:showText(npc,ILITA_SHOP_DIALOG,513);

    stock = {
        0x3F9D,   375        --Pendant Compass
    }
    showShop(player, STATIC, stock);

end;

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;
