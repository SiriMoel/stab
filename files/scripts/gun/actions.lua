dofile_once("mods/stab/files/scripts/utils.lua")

local new_actions = {
	{
		id = "STAB",
		name = "$action_stab_stab",
		description = "$actiondesc_stab_stab",
		sprite = "mods/stab/files/ui_gfx/gun_actions/stab.png",
		type = ACTION_TYPE_OTHER,
		spawn_level = "10",
		spawn_probability = "0",
		price = 300,
		mana = 80,
		ai_never_uses = true,
		custom_xml_file="mods/stab/files/entities/misc/card_stab/card.xml",
		action = function()
			--c.fire_rate_wait = c.fire_rate_wait + 42
			--current_reload_time = current_reload_time + 42
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
						EntityInflictDamage(stab_target, 4, "DAMAGE_SLICE", "", "BLOOD_EXPLOSION", 1, 1, caster, nil, nil, 2)
						Stabfx(caster, stab_target)
					end						
					local effects = EntityGetAllChildren(caster, "stab_big_earner") or {}
					if #effects == 0 then
						LoadGameEffectEntityTo(caster, "mods/stab/files/entities/misc/effect_big_earner.xml")
					end	
					c.fire_rate_wait = c.fire_rate_wait + 42
					current_reload_time = current_reload_time + 42
					-- refresh? probably a bad idea
					--[[for i,v in ipairs(hand) do table.insert(discarded, v) end
					for i,v in ipairs(deck) do table.insert(discarded, v) end
					hand = {}
					deck = {}
					if force_stop_draws == false then
						force_stop_draws = true
						move_discarded_to_deck()
						order_deck()
					end]]
				else
					mana = mana + 80
					draw_actions(1, true)
				end
			end
		end,
	},
}

for i,action in ipairs(new_actions) do
	action.id = "STAB_" .. action.id
	table.insert(actions, action)
end