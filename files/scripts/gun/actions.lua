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
				c.damage_slice_add = c.damage_slice_add + 2.8
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
						local damage = 2.8 * c.stab_stab_stab
						EntityInflictDamage(stab_target, damage, "DAMAGE_SLICE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
						Stabfx(caster, stab_target)
					end						
					local effects = EntityGetAllChildren(caster, "stab_big_earner") or {}
					if #effects == 0 then
						local effect_entity = LoadGameEffectEntityTo(caster, "mods/stab/files/entities/misc/effect_big_earner.xml")
						local gec = EntityGetFirstComponent(effect_entity, "GameEffectComponent")
						if gec ~= nil then
							ComponentSetValue2(gec, "frames", 250 + 60 * c.stab_power)
						end
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
		type = ACTION_TYPE_UTILITY,
		spawn_level = "10",
		spawn_probability = "0",
		price = 200,
		mana = 50,
		ai_never_uses = true,
		custom_xml_file="mods/stab/files/entities/misc/card_stab_fire.xml",
		action = function()
			if reflecting then
				c.damage_slice_add = c.damage_slice_add + 1.6
				c.damage_fire_add = c.damage_fire_add + 2.4
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
						ComponentSetValue2(effect_comp, "frames", 540 + 60 * c.stab_power)
						if ModIsEnabled("foolish_flame") then
							dofile_once("mods/foolish_flame/files/scripts/utils.lua")
							local temperature = math.min(5 + c.stab_power, 10)
							local duration = 540 + 120 * c.stab_power
							InflictMagicFire(stab_target, temperature, duration, 10)
						end
						local damage = 4 * c.stab_stab_stab
						EntityInflictDamage(stab_target, damage * 0.43, "DAMAGE_SLICE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
						EntityInflictDamage(stab_target, damage * 0.57, "DAMAGE_FIRE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
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
						local damage = 1 * c.stab_stab_stab
						EntityInflictDamage(stab_target, damage, "DAMAGE_SLICE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
						Stabfx(caster, stab_target)
					end						
					local effects = EntityGetAllChildren(caster, "stab_misericorde") or {}
					if #effects == 0 then
						local effect_entity = LoadGameEffectEntityTo(caster, "mods/stab/files/entities/misc/effect_misericorde/effect.xml")
						local comp_mis_amt = EntityGetFirstComponentIncludingDisabled(effect_entity, "VariableStorageComponent", "mis_amt")
						if comp_mis_amt ~= nil then
							ComponentSetValue2(comp_mis_amt, "value_float", 0.4 + 0.15 * c.stab_power)
						end
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
		id = "GETAWAY",
		name = "$action_stab_getaway",
		description = "$actiondesc_stab_getaway",
		sprite = "mods/stab/files/ui_gfx/gun_actions/getaway.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level = "10",
		spawn_probability = "0",
		price = 200,
		mana = 60,
		ai_never_uses = true,
		custom_xml_file="mods/stab/files/entities/misc/card_stab/card.xml",
		action = function()
			if reflecting then
				c.damage_slice_add = c.damage_slice_add + 4
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
						local damage = 4 * c.stab_stab_stab
						EntityInflictDamage(stab_target, damage, "DAMAGE_SLICE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
						Stabfx(caster, stab_target)
					end						
					local x, y = EntityGetTransform(caster)
					y = y - 4
					local count = 0
					local done = false
					local dist = 400
					while not done and count < 10 do
						SetRandomSeed(x + count, y)
						count = count + 1
						local angle = math.rad(Random(1, 360))
						local tx, ty = x + math.cos(angle) * dist, y + math.sin(angle) * dist
						local did_hit, hx, hy = RaytracePlatforms(x, y, tx, ty)
						local dx, dy = hx, hy
						if did_hit then
							dx, dy = dx - math.cos(angle) * 20, dy - math.sin(angle) * 20
						end
						EntitySetTransform(caster, dx, dy)
						EntityLoad("data/entities/particles/teleportation_source.xml", x, y)
						EntityLoad("data/entities/particles/teleportation_target.xml", dx, dy)
						GamePlaySound("data/audio/Desktop/misc.bank","misc/teleport_use", dx, dy)
						LoadPixelScene("data/biome_impl/teleportitis_dodge_hole.png", "", dx-3, dy-12, "", true)
						done = true
					end
					if done then
						local effects = EntityGetAllChildren(caster, "stab_getaway") or {}
						if #effects == 0 then
							local effect_entity = LoadGameEffectEntityTo(caster, "mods/stab/files/entities/misc/effect_getaway.xml")
							local gec = EntityGetFirstComponent(effect_entity, "GameEffectComponent")
							if gec ~= nil then
								ComponentSetValue2(gec, "frames", 900 + 90 * c.stab_power)
							end
						end	
					end
					c.fire_rate_wait = c.fire_rate_wait + 42
					current_reload_time = current_reload_time + 42
				else
					mana = mana + 60
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
		mana = 130,
		ai_never_uses = true,
		custom_xml_file="mods/stab/files/entities/misc/card_buff.xml",
		action = function()
			if reflecting then
				c.damage_slice_add = c.damage_slice_add + 2.4
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
						local damage = 2.4 * c.stab_stab_stab
						EntityInflictDamage(stab_target, damage, "DAMAGE_SLICE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
					end
					local effects = EntityGetAllChildren(caster, "stab_effect_buff") or {}
					local max = math.min(5 + c.stab_power, 14)
					if #effects < max then
						local effect = EntityLoad("mods/stab/files/entities/misc/effect_buff.xml", x, y)
						EntityAddChild(caster, effect)
					end
					c.fire_rate_wait = c.fire_rate_wait + 54
					current_reload_time = current_reload_time + 54
				else
					mana = mana + 130
				end
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "ENGINE",
		name = "$action_stab_engine",
		description = "$actiondesc_stab_engine",
		sprite = "mods/stab/files/ui_gfx/gun_actions/engine.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level = "10",
		spawn_probability = "0",
		price = 200,
		mana = 80,
		ai_never_uses = true,
		custom_xml_file="mods/stab/files/entities/misc/card_engine.xml",
		action = function()
			if reflecting then
				c.damage_slice_add = c.damage_slice_add + 2.8
				return
			end
			local caster = GetUpdatedEntityID()
			if EntityHasTag(caster, "player_unit") then
				local effects = EntityGetAllChildren(caster, "stab_effect_engine") or {}
				local effect_count = #effects
				local comp_stab = EntityGetFirstComponentIncludingDisabled(caster, "VariableStorageComponent", "stab_")
				local can_stab = ComponentGetValue2(comp_stab, "value_bool")
				if can_stab then
					local x, y = EntityGetTransform(caster)
					local comp_stab_entity = EntityGetFirstComponentIncludingDisabled(caster, "VariableStorageComponent", "stab_target")
					if comp_stab_entity ~= nil then
						local stab_target = ComponentGetValue2(comp_stab_entity, "value_int")
						Stabfx(caster, stab_target)
						local damage = 2.8 * c.stab_stab_stab
						EntityInflictDamage(stab_target, damage, "DAMAGE_SLICE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
					end
					local max = math.min(3 + c.stab_power, 5)
					if effect_count < max then
						local effect = EntityLoad("mods/stab/files/entities/misc/effect_engine.xml", x, y)
						EntityAddChild(caster, effect)
						effect_count = effect_count + 1
					end
					c.fire_rate_wait = c.fire_rate_wait + 42
					current_reload_time = current_reload_time + 42
				else
					mana = mana + 80
					if effect_count > 0 then
						c.fire_rate_wait = c.fire_rate_wait - 24 * effect_count
						current_reload_time = current_reload_time  - 18 * effect_count
					end
				end
				
			end
			draw_actions(1, true)
		end,
	},
	{
		id = "STABAGE",
		name = "$action_stab_stabage",
		description = "$actiondesc_stab_stabage",
		sprite = "mods/stab/files/ui_gfx/gun_actions/stabage.png",
		spawn_requires_flag = "stab_spell_acquired",
		type = ACTION_TYPE_OTHER, -- not a modifier because it doesn't modify a projectile
		spawn_level = "10",
		spawn_probability = "0",
		price = 200,
		mana = 0, --mana = 30,
		ai_never_uses = true,
		action = function()
			--current_reload_time = current_reload_time + 12
			c.stab_stab_stab = c.stab_stab_stab + 0.5
			draw_actions(1, true)
		end,
	},
	{
		id = "POWER",
		name = "$action_stab_power",
		description = "$actiondesc_stab_power",
		sprite = "mods/stab/files/ui_gfx/gun_actions/power.png",
		spawn_requires_flag = "stab_spell_acquired",
		type = ACTION_TYPE_OTHER, -- not a modifier because it doesn't modify a projectile
		spawn_level = "10",
		spawn_probability = "0",
		price = 200,
		mana = 0, --mana = 35,
		ai_never_uses = true,
		action = function()
			--current_reload_time = current_reload_time + 12
			c.stab_power = c.stab_power + 1
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