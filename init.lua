dofile_once("mods/stab/files/scripts/utils.lua")

local nxml = dofile_once("mods/stab/lib/nxml.lua")

-- appends
ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/stab/files/scripts/gun/actions.lua")
ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/stab/files/scripts/gun/gun_append.lua")

-- translations
local translations = ModTextFileGetContent("data/translations/common.csv")
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n","\r\n")
    end
    local new_translations = ModTextFileGetContent(table.concat({"mods/stab/files/translations.csv"}))
    translations = translations .. new_translations
    ModTextFileSetContent("data/translations/common.csv", translations)
end

-- boss drops
local bosses = {
	"data/entities/animals/boss_alchemist/boss_alchemist.xml",
	"data/entities/animals/boss_limbs/boss_limbs.xml",
	"data/entities/animals/boss_pit/boss_pit.xml",
	"data/entities/animals/boss_dragon.xml",
	"data/entities/animals/boss_wizard/boss_wizard.xml",
	"data/entities/animals/boss_fish/fish_giga.xml",
	"data/entities/animals/boss_spirit/islandspirit.xml",
	"data/entities/animals/boss_ghost/boss_ghost.xml",
	"data/entities/animals/boss_meat/boss_meat.xml",
	"data/entities/animals/boss_robot/boss_robot.xml",
	"data/entities/animals/maggot_tiny/maggot_tiny.xml",
	"data/entities/animals/parallel/alchemist/parallel_alchemist.xml",
	"data/entities/animals/parallel/tentacles/parallel_tentacles.xml",
}
for _,path in ipairs(bosses) do
    for content in nxml.edit_file(path) do
        content:create_children(
	        { LuaComponent = {
	    		script_death="mods/stab/files/scripts/boss_death.lua"
	    	}}
        )
    end
end


function OnModPostInit()
	if ModIsEnabled("foolish_flame") then
		ModLuaFileAppend("mods/foolish_flame/files/scripts/bounty_rewards.lua", "mods/stab/files/scripts/ff_bounty_rewards.lua")
		ModLuaFileAppend("mods/foolish_flame/files/scripts/gauges.lua", "mods/stab/files/scripts/ff_gauges.lua")
	end
end

function OnPlayerSpawned(player)
    if GameHasFlagRun("stab_init") then return end
	GameAddFlagRun("stab_init")

	GlobalsSetValue("stab_show_stab_indicator", tostring(ModSettingGet("stab.show_stab_indicator")))
	GlobalsSetValue("stab_stab_range", tostring(ModSettingGet("stab.stab_range")))

	EntityAddComponent2(player, "VariableStorageComponent", {
		_tags="stab_",
		name="stab_",
		value_bool=false
	})

    EntityAddComponent2(player, "VariableStorageComponent", {
		_tags="stab_target",
		name="stab_target",
		value_int=0
	})

    EntityAddComponent2(player, "VariableStorageComponent", {
		_tags="stab_wand_sprite",
		name="stab_wand_sprite",
		value_string=""
	})
end

function OnPausedChanged(is_paused, is_inventory_pause)
    if is_paused then
		local show_stab_indicator = ModSettingGet("stab.show_stab_indicator") or false
		GlobalsSetValue("stab_show_stab_indicator", tostring(show_stab_indicator))
		local stab_range = ModSettingGet("stab.stab_range") or "34"
		GlobalsSetValue("stab_stab_range", tostring(stab_range))
	end
end
