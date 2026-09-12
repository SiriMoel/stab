dofile("data/scripts/lib/mod_settings.lua")

function mod_setting_bool_stab(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "boolean" then value = setting.value_default or false end

	local text = GameTextGet(value and "$stab_setting_on" or "$stab_setting_off")

	if in_main_menu then
		text = value and "ON!" or "Off"
	end

    if value then
        GuiColorSetForNextWidget(gui, 0.9, 0.7, 1.0, 1.0)
    else
        GuiColorSetForNextWidget(gui, 0.5, 0.3, 0.3, 1.0)
    end

	GuiText(gui, mod_setting_group_x_offset, 0, text, 1, "", true)

    GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 1)

    local clicked,right_clicked = GuiButton(gui, im_id, mod_setting_group_x_offset + 24, -11, setting.ui_name)

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

function mod_setting_change_callback(mod_id, gui, in_main_menu, setting, old_value, new_value)

end

local mod_id = "stab"
mod_settings_version = 1
mod_settings = {
	{
        id = "spell_STAB",
        ui_name = "Spell: Big Earner",
        ui_description = "Should this spell exist?",
        value_default = true,
        scope = MOD_SETTING_SCOPE_NEW_GAME,
        ui_fn = mod_setting_bool_stab,
        value_type = "boolean",
    },
	{
        id = "spell_FIRE",
        ui_name = "Spell: Stabbing Fire",
        ui_description = "Should this spell exist?",
        value_default = true,
        scope = MOD_SETTING_SCOPE_NEW_GAME,
        ui_fn = mod_setting_bool_stab,
        value_type = "boolean",
    },
	{
        id = "spell_MISERICORDE",
        ui_name = "Spell: Minä's Misericorde",
        ui_description = "Should this spell exist?",
        value_default = true,
        scope = MOD_SETTING_SCOPE_NEW_GAME,
        ui_fn = mod_setting_bool_stab,
        value_type = "boolean",
    },
    {
        id = "spell_GETAWAY",
        ui_name = "Spell: Getaway",
        ui_description = "Should this spell exist?",
        value_default = true,
        scope = MOD_SETTING_SCOPE_NEW_GAME,
        ui_fn = mod_setting_bool_stab,
        value_type = "boolean",
    },
	{
        id = "spell_BUFF",
        ui_name = "Spell: Essence Extractor",
        ui_description = "Should this spell exist?",
        value_default = true,
        scope = MOD_SETTING_SCOPE_NEW_GAME,
        ui_fn = mod_setting_bool_stab,
        value_type = "boolean",
    },
    {
        id = "spell_STABAGE",
        ui_name = "Spell: Stabage",
        ui_description = "Should this spell exist?",
        value_default = true,
        scope = MOD_SETTING_SCOPE_NEW_GAME,
        ui_fn = mod_setting_bool_stab,
        value_type = "boolean",
    },
    {
        id = "spell_POWER",
        ui_name = "Spell: Stab! Power",
        ui_description = "Should this spell exist?",
        value_default = true,
        scope = MOD_SETTING_SCOPE_NEW_GAME,
        ui_fn = mod_setting_bool_stab,
        value_type = "boolean",
    },
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