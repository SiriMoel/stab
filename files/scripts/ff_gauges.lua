    local gauges_to_add = {
    {
        id = "stab",
        name = "$stab_ff_gauge",
        name_t = "Stab! Gauge",
        sprite = "mods/stab/files/ui_gfx/stab_gauge/sprite.png",
        func_unlocked = function() return true end,
        custom_logic = function(heat) 
            local sprite = "mods/stab/files/ui_gfx/stab_gauge/sprite.png"
            local player = GetUpdatedEntityID()
            local can_stab = false
            local hot = false
            if heat >= 400 then hot = true end
            local comp_inv = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
            if comp_inv ~= nil then
                local held_item = ComponentGetValue2(comp_inv, "mActiveItem")
                if hot then
                    sprite = "mods/stab/files/ui_gfx/stab_gauge/sprite_hot.png"
                end
                local c = EntityGetAllChildren(held_item, "stab_card") or {}
                if #c > 0 then
                    local comp_stab = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "stab_")
			        if comp_stab ~= nil then
                        can_stab = ComponentGetValue2(comp_stab, "value_bool")
                    end
                    if hot and can_stab then
                        return "mods/stab/files/ui_gfx/stab_gauge/sprite_stab_hot.png"
                    elseif can_stab then
                        return "mods/stab/files/ui_gfx/stab_gauge/sprite_stab.png"
                    end
                end
            end
            return sprite
        end,
    },
}

for i,gauge in ipairs(gauges_to_add) do
    table.insert(heat_gauges, gauge)
end
