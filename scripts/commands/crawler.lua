---------------------------------------------------------------------------------------------------
-- func: crawler
-- desc: summons Crawler as a mount
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
}

function onTrigger(player)

    local current_rank = player:getRank()
    local duration = 1800 + (player:getMod(dsp.mod.CHOCOBO_RIDING_TIME) * 60)

    if player:getZone():canUseMisc(dsp.zoneMisc.MOUNT) and player:hasKeyItem(dsp.ki.CHOCOBO_LICENSE)
        and current_rank == 10 then
        player:addStatusEffectEx(dsp.effect.MOUNTED,dsp.effect.MOUNTED,9,0,duration,true)
    else
        player:PrintToPlayer("<GryphonMsg> You need Chocobo License and Rank 10, or you can't ride mounts here!", 0xE)
    end
end
