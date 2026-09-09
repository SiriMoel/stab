local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

if EntityHasTag(root, "player_unit") then
    local dmc = EntityGetFirstComponent(root, "DamageModelComponent")
    local comp_max_hp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "mis_max_hp")
    --local comp_hp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "mis_hp")
    local comp_amt = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "mis_amt")
    if dmc ~= nil then
        local max_hp = ComponentGetValue2(dmc, "max_hp")
        local hp = ComponentGetValue2(dmc, "hp")
        ComponentSetValue2(comp_max_hp, "value_float", max_hp)
        --ComponentSetValue2(comp_hp, "value_float", hp)
        local amt = math.max(max_hp * 0.4, 0.4)
        ComponentSetValue2(comp_amt, "value_float", amt)
        ComponentSetValue2(dmc, "max_hp", max_hp + amt)
        ComponentSetValue2(dmc, "hp", hp + amt)
    end
end