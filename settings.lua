dofile("data/scripts/lib/mod_settings.lua")

function mod_setting_bool_ff(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "boolean" then value = setting.value_default or false end

	local text = GameTextGet(value and "$ff_setting_on" or "$ff_setting_off")

    if value then
        GuiColorSetForNextWidget(gui, 1.0, 0.9, 0.7, 1.0)
    else
        GuiColorSetForNextWidget(gui, 0.4, 0.4, 0.6, 1.0)
    end

	GuiText(gui, mod_setting_group_x_offset, 0, text, 1, "", true)

    GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 1)

    local clicked,right_clicked = GuiButton( gui, im_id, mod_setting_group_x_offset + 24, -11, setting.ui_name )

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)

    if clicked then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value, not value )
	end
	if right_clicked then
		local new_value = setting.value_default or false
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), new_value, false )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value, new_value )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_enum_ff(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "string" then value = setting.value_default or "" end

	local value_id = 1
	for i,val in ipairs(setting.values) do
		if val[1] == value then
			value_id = i
			break
		end
	end

	local text = setting.values[value_id][2]

    local p = value_id / #setting.values

    GuiColorSetForNextWidget(gui, 0.6 + 0.4 * p, 0.9 - 0.4 * p, 0.3 + 0.4 * p, 1.0)

	GuiText(gui, mod_setting_group_x_offset, 0, text, 1, "", true)
	
    GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 1)

    local clicked,right_clicked = GuiButton(gui, im_id, mod_setting_group_x_offset + 24, -11, setting.ui_name)

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)

    if clicked then
		local value_old = value
		value_id = value_id + 1
		if value_id > #(setting.values) then
			value_id = 1
		end
		value = setting.values[value_id][1]
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), value, false  )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value_old, value )
	end
	if right_clicked and setting.value_default then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), setting.value_default, false  )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value, setting.value_default )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_image_small(mod_id, gui, in_main_menu, im_id, setting)
	GuiImage(gui, im_id, mod_setting_group_x_offset, 0, setting.image_filename, 1, 0.5, 0)

	if is_visible_string(setting.ui_description) then
		GuiTooltip(gui, setting.ui_description, "")
	end
end

function mod_setting_change_callback(mod_id, gui, in_main_menu, setting, old_value, new_value)

end

local mod_id = "foolish_flame"
mod_settings_version = 1
mod_settings = {
	
}

function ModSettingsUpdate(init_scope)
	local old_version = mod_settings_get_version(mod_id)
	mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
	return mod_settings_gui_count(mod_id, mod_settings)
end

function ModSettingsGui(gui, in_main_menu)
	mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end