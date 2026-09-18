dofile_once("mods/stab/files/scripts/utils.lua")

local card = GetUpdatedEntityID()

local root = EntityGetRootEntity(card)

if EntityHasTag(root, "player_unit") and (GlobalsGetValue("stab_show_stab_indicator", "true") == "true") then
    local x, y, r, sx, sy = EntityGetTransform(root)
    local can_stab, stab_val, stab_entity, mx = CanStab(root, card, x, y)
    if can_stab and mx == sx then
        local comp_inv = EntityGetFirstComponentIncludingDisabled(root, "Inventory2Component")
        if comp_inv ~= nil then
            local held_item = ComponentGetValue2(comp_inv, "mActiveItem")
            if EntityHasTag(held_item, "wand") then
                local comp_ability = EntityGetFirstComponentIncludingDisabled(held_item, "AbilityComponent")
                if comp_ability ~= nil then
                    local sprite = ComponentGetValue2(comp_ability, "sprite_file")
                    local comp_spec = EntityGetFirstComponentIncludingDisabled(card, "SpriteParticleEmitterComponent")
                    if comp_spec ~= nil then
                        ComponentSetValue2(comp_spec, "sprite_file", sprite)
                        ComponentSetValue2(comp_spec, "scale", mx, 1)
                        local rot = 0.6 * stab_val * mx
                        ComponentSetValue2(comp_spec, "rotation", rot)
                    end
                    local comp_stab_sprite = EntityGetFirstComponentIncludingDisabled(root, "VariableStorageComponent", "stab_wand_sprite")
                    if comp_stab_sprite ~= nil then
                        ComponentSetValue2(comp_stab_sprite, "value_string", sprite)
                    end
                end
                local offset_x, offset_y = math.random(-5, 5), math.random(-2, 2) - 4
                GameCreateCosmeticParticle("spark_purple", x + 7 * sx + offset_x, y - 12 + offset_y, math.random(0, math.ceil(4 * stab_val)), 4, 4, nil, 0, 0.4 * stab_val, true, false, true, true, 0, 0)
                local stab_x, stab_y = EntityGetTransform(stab_entity)
                GameCreateCosmeticParticle("spark_purple", stab_x + offset_x * 0.5, stab_y + offset_y * 2, 1, 3, 3, nil, 0.2, 1, true, false, true, true, 0, 0)
            end
        end
        EntitySetComponentsWithTagEnabled(card, "stab", true)
    else
    EntitySetComponentsWithTagEnabled(card, "stab", false)
    end
end