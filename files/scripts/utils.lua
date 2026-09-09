dofile_once("data/scripts/lib/utilities.lua")

STAB_RANGE = 34

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
        return true
    end
end
    return false
end

function CanStab(player, card, x, y)
    local can_stab = false
    local stab_val = 0
    local stab_entity
    local targets = EntityGetInRadiusWithTag(x, y, STAB_RANGE, "mortal") or {}
    local comp_frame = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "stab_frame")
    local frame_now = GameGetFrameNum()
    local dist_x = 1
    if #targets > 0 then
        for i,target in ipairs(targets) do
            local tx, ty = EntityGetTransform(target)
            if not EntityHasTag(target, "player_unit") and not RaytraceSurfaces(x, y, tx, ty) and y <= ty then
                can_stab = true
                stab_entity = target
                if tx - x < 0 then
                    dist_x = -1
                end
                break
            end
        end
    end
    if can_stab then
        local frame_stab = ComponentGetValue2(comp_frame, "value_int")
        stab_val = math.min(frame_now - frame_stab, 18) / 18
        local comp_stab_entity = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "stab_target")
        if comp_stab_entity ~= nil then
            ComponentSetValue2(comp_stab_entity, "value_int", stab_entity)
        end
    else
        ComponentSetValue2(comp_frame, "value_int", frame_now)
    end
    local comp_stab = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "stab_")
    ComponentSetValue2(comp_stab, "value_bool", can_stab)
    return can_stab, stab_val, stab_entity, dist_x
end

function Stabfx(stabber, stabbed)
    local pos_x, pos_y = EntityGetTransform(stabbed)
	GameCreateCosmeticParticle("blood", pos_x, pos_y, 30, 20, 20, nil, 0.2, 0.6, true, false, true, true, 0, 90)
	local comp_stab_sprite = EntityGetFirstComponentIncludingDisabled(stabber, "VariableStorageComponent", "stab_wand_sprite")
	if comp_stab_sprite ~= nil then
		local entity_fx = EntityLoad("mods/stab/files/entities/misc/stab_fx.xml", pos_x, pos_y - 20)
		local comp_spec = EntityGetFirstComponentIncludingDisabled(entity_fx, "SpriteParticleEmitterComponent")
		if comp_spec ~= nil then
			local wand_sprite = ComponentGetValue2(comp_stab_sprite, "value_string")
			ComponentSetValue2(comp_spec, "sprite_file", wand_sprite)
		end
	end
	GamePlaySound("data/audio/Desktop/player.bank", "player/damage/melee", pos_x, pos_y)
	GamePlaySound("data/audio/Desktop/projectiles.bank", "player_projectiles/bullet_disc/bounce", pos_x, pos_y)
end