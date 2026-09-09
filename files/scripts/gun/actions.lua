dofile_once("mods/stab/files/scripts/utils.lua")

local new_actions = {
	{
		id = "STAB",
		name = "$action_stab_stab",
		description = "$actiondesc_stab_stab",
		sprite = "mods/stab/files/ui_gfx/gun_actions/stab.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level = "10",
		spawn_probability = "0",
		price = 200,
		mana = 70,
		ai_never_uses = true,
		custom_xml_file="mods/stab/files/entities/misc/card_stab/card.xml",
		action = function()
			if reflecting then
				c.damage_slice_add = c.damage_slice_add + 4
				c.fire_rate_wait = c.fire_rate_wait + 48
				current_reload_time = current_reload_time + 48
				return
			end
			local caster = GetUpdatedEntityID()
			if EntityHasTag(caster, "player_unit") then
				local comp_stab = EntityGetFirstComponentIncludingDisabled(caster, "VariableStorageComponent", "stab_")
				local can_stab = ComponentGetValue2(comp_stab, "value_bool")
				if can_stab then
					local comp_stab_entity = EntityGetFirstComponentIncludingDisabled(caster, "VariableStorageComponent", "stab_target")
					if comp_stab_entity ~= nil then
						local stab_target = ComponentGetValue2(comp_stab_entity, "value_int")
						EntityInflictDamage(stab_target, 4, "DAMAGE_SLICE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
						Stabfx(caster, stab_target)
					end						
					local effects = EntityGetAllChildren(caster, "stab_big_earner") or {}
					if #effects == 0 then
						LoadGameEffectEntityTo(caster, "mods/stab/files/entities/misc/effect_big_earner.xml")
					end	
					c.fire_rate_wait = c.fire_rate_wait + 48
					current_reload_time = current_reload_time + 48
				else
					mana = mana + 70
				end
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "FIRE",
		name = "$action_stab_fire",
		description = "$actiondesc_stab_fire",
		sprite = "mods/stab/files/ui_gfx/gun_actions/stabbing_fire.png",
		type = ACTION_TYPE_OTHER,
		spawn_level = "10",
		spawn_probability = "0",
		price = 200,
		mana = 50,
		ai_never_uses = true,
		custom_xml_file="mods/stab/files/entities/misc/card_stab_fire.xml",
		action = function()
			if reflecting then
				c.damage_slice_add = c.damage_slice_add + 3
				c.damage_fire_add = c.damage_fire_add + 4
				c.fire_rate_wait = c.fire_rate_wait + 42
				current_reload_time = current_reload_time + 42
				return
			end
			local caster = GetUpdatedEntityID()
			if EntityHasTag(caster, "player_unit") then
				local comp_stab = EntityGetFirstComponentIncludingDisabled(caster, "VariableStorageComponent", "stab_")
				local can_stab = ComponentGetValue2(comp_stab, "value_bool")
				if can_stab then
					local comp_stab_entity = EntityGetFirstComponentIncludingDisabled(caster, "VariableStorageComponent", "stab_target")
					if comp_stab_entity ~= nil then
						local stab_target = ComponentGetValue2(comp_stab_entity, "value_int")
						local effect_comp, effect_entity = GetGameEffectLoadTo(stab_target, "ON_FIRE", true)
						ComponentSetValue2(effect_comp, "frames", 600)
						if ModIsEnabled("foolish_flame") then
							dofile_once("mods/foolish_flame/files/scripts/utils.lua")
							InflictMagicFire(stab_target, 5, 600, 10)
						end
						EntityInflictDamage(stab_target, 3, "DAMAGE_SLICE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
						EntityInflictDamage(stab_target, 4, "DAMAGE_FIRE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
						Stabfx(caster, stab_target)
					end
					c.fire_rate_wait = c.fire_rate_wait + 42
					current_reload_time = current_reload_time + 42
				else
					mana = mana + 50
				end
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "MISERICORDE",
		name = "$action_stab_health",
		description = "$actiondesc_stab_health",
		sprite = "mods/stab/files/ui_gfx/gun_actions/misericorde.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level = "10",
		spawn_probability = "0",
		price = 300,
		mana = 110,
		ai_never_uses = true,
		custom_xml_file="mods/stab/files/entities/misc/card_misericorde.xml",
		action = function()
			if reflecting then
				c.damage_slice_add = c.damage_slice_add + 1
				c.fire_rate_wait = c.fire_rate_wait + 84
				current_reload_time = current_reload_time + 84
				return
			end
			local caster = GetUpdatedEntityID()
			if EntityHasTag(caster, "player_unit") then
				local comp_stab = EntityGetFirstComponentIncludingDisabled(caster, "VariableStorageComponent", "stab_")
				local can_stab = ComponentGetValue2(comp_stab, "value_bool")
				if can_stab then
					local comp_stab_entity = EntityGetFirstComponentIncludingDisabled(caster, "VariableStorageComponent", "stab_target")
					if comp_stab_entity ~= nil then
						local stab_target = ComponentGetValue2(comp_stab_entity, "value_int")
						EntityInflictDamage(stab_target, 1, "DAMAGE_SLICE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
						Stabfx(caster, stab_target)
					end						
					local effects = EntityGetAllChildren(caster, "stab_misericorde") or {}
					if #effects == 0 then
						LoadGameEffectEntityTo(caster, "mods/stab/files/entities/misc/effect_misericorde/effect.xml")
					end	
					c.fire_rate_wait = c.fire_rate_wait + 84
					current_reload_time = current_reload_time + 84
				else
					mana = mana + 110
				end
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "BUFF",
		name = "$action_stab_buff",
		description = "$actiondesc_stab_buff",
		sprite = "mods/stab/files/ui_gfx/gun_actions/buff.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level = "10",
		spawn_probability = "0",
		price = 200,
		mana = 80,
		ai_never_uses = true,
		custom_xml_file="mods/stab/files/entities/misc/card_buff.xml",
		action = function()
			if reflecting then
				c.damage_slice_add = c.damage_slice_add + 3
				c.fire_rate_wait = c.fire_rate_wait + 54
				current_reload_time = current_reload_time + 54
				return
			end
			local caster = GetUpdatedEntityID()
			if EntityHasTag(caster, "player_unit") then
				local comp_stab = EntityGetFirstComponentIncludingDisabled(caster, "VariableStorageComponent", "stab_")
				local can_stab = ComponentGetValue2(comp_stab, "value_bool")
				if can_stab then
					local x, y = EntityGetTransform(caster)
					local comp_stab_entity = EntityGetFirstComponentIncludingDisabled(caster, "VariableStorageComponent", "stab_target")
					if comp_stab_entity ~= nil then
						local stab_target = ComponentGetValue2(comp_stab_entity, "value_int")
						Stabfx(caster, stab_target)
						if ModIsEnabled("souls") then
							SetRandomSeed(x, y)
							dofile_once("mods/souls/files/scripts/souls.lua")
							ReapSoul(stab_target, Random(1, 3), false)
						end
						EntityInflictDamage(stab_target, 3, "DAMAGE_SLICE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
					end
					local effect = EntityLoad("data/entities/misc/effect_damage_plus_small.xml", x, y)
					EntityAddChild(caster, effect)
					c.fire_rate_wait = c.fire_rate_wait + 54
					current_reload_time = current_reload_time + 54
				else
					mana = mana + 80
				end
			end
			draw_actions(1, true)
		end,
	},
}

for i,action in ipairs(new_actions) do
	if ModSettingGet("stab.spell_" .. action.id) then
		action.id = "STAB_" .. action.id
		table.insert(actions, action)
	end
end