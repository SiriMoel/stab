local gauges_to_add = {
    {
        id = "stab",
        name = "$stab_ff_gauge",
        name_t = "Stab! Gauge",
        sprite = "mods/stab/files/ui_gfx/stab_gauge/sprite.png",
        draw_order = {
            "SPRITE", "HOT", "STEP", "STAB"
        },
        func_unlocked = function() return true end,
        custom_logic = function(heat) 
            local sprite = "mods/stab/files/ui_gfx/stab_gauge/sprite.png"
            local player = GetUpdatedEntityID()
            local sprites = {
                SPRITE = "mods/stab/files/ui_gfx/stab_gauge/sprite.png",
                STAB = nil,
                HOT = nil,
            }
            if heat >= 400 then
                sprites["HOT"] = "mods/stab/files/ui_gfx/stab_gauge/sprite_hot.png"
            end
            local comp_stab = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "stab_")
            local can_stab = ComponentGetValue2(comp_stab, "value_bool")
            if can_stab then
                local comp_inv = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
                if comp_inv ~= nil then
                    local held_item = ComponentGetValue2(comp_inv, "mActiveItem")
                    local c = EntityGetAllChildren(held_item, "stab_card") or {}
                    if #c > 0 then
                        sprites["STAB"] = "mods/stab/files/ui_gfx/stab_gauge/sprite_stab.png"
                    end
                end
            end
            return sprites
        end,
    },
}

for i,gauge in ipairs(gauges_to_add) do
    table.insert(heat_gauges, gauge)
end