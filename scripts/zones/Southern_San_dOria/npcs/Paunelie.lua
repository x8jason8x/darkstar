-----------------------------------
-- Area: S. Sandy
-- NPC: Paunelie
-- Linkshell merchant
-- !pos -142 -1 -25 236
-----------------------------------
package.loaded["scripts/zones/Southern_San_dOria/TextIDs"] = nil
-----------------------------------
require("scripts/zones/Southern_San_dOria/TextIDs")
require("scripts/globals/shop")


function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local stock =
    {
        0x3f9d,375   -- Pendant Compass
    }

    player:showText(npc, PAUNELIE_SHOP_DIALOG, 513)
    dsp.shop.general(player, stock)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end
