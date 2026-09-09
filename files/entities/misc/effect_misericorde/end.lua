local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

if EntityHasTag(root, "player_unit") then
    local dmc = EntityGetFirstComponent(root, "DamageModelComponent")
    local comp_max_hp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "mis_max_hp")
    --local comp_hp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "mis_hp")
    if dmc ~= nil then
        local max_hp = ComponentGetValue2(dmc, "max_hp")
        local hp = ComponentGetValue2(dmc, "hp")
        local max_hp_start = ComponentGetValue2(comp_max_hp, "value_float")
        --local hp_start = ComponentGetValue2(comp_hp, "value_float")
        max_hp = math.floor((math.max(max_hp, max_hp_start) / 0.04) + 0.5) * 0.04
        --hp = math.ceil(math.max(hp, hp_start) / 0.04) * 0.04 -- hmm
        hp = math.floor((hp / 0.04) + 0.5) * 0.04
        ComponentSetValue2(dmc, "max_hp", max_hp)
        ComponentSetValue2(dmc, "hp", hp)
    end
end