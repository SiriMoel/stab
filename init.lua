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

function OnPlayerSpawned(player)
    if GameHasFlagRun("stab_init") then return end
	GameAddFlagRun("stab_init")

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