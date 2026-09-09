local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local every_n_frame = 12
local total_duration = 1200

if EntityHasTag(root, "player_unit") then
    local dmc = EntityGetFirstComponent(root, "DamageModelComponent")
    local comp_amt = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "mis_amt")
    if dmc ~= nil then
        local max_hp = ComponentGetValue2(dmc, "max_hp")
        local hp = ComponentGetValue2(dmc, "hp")
        local amt = ComponentGetValue2(comp_amt, "value_float")
        amt = amt * every_n_frame / total_duration
        ComponentSetValue2(dmc, "max_hp", math.max(max_hp - amt, 0.04))
        ComponentSetValue2(dmc, "hp", math.max(hp - amt, 0.04))
    end
end