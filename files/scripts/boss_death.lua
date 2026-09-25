dofile_once("mods/stab/files/scripts/utils.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    local flag = HasFlagPersistent("stab_spell_acquired")

    SetRandomSeed(x, y)

	local name = EntityGetName(entity)

    local function stab_boost_spell(x, y)
        if flag then
            local first = "STABAGE"
            local second = "POWER"
            if Random(1, 2) == 1 then
                first = "POWER"
                second = "STABAGE"
            end
            if not CreateStabSpell(first, x, y) then CreateStabSpell(second, x, y) end
        end
    end

    if name == "$animal_parallel_alchemist" or name == "$animal_parallel_tentacles" then
        local num = Random(1, 6)
        local opts = {}
        if num <= 4 then
            local possible_opts = {"STABAGE", "POWER"}
            for i,v in ipairs(possible_opts) do
                if ModSettingGet("stab.spell_" .. v) then
                    table.insert(opts, v)
                end
            end
        end
        if #opts > 0 then
            local action = opts[Random(1, #opts)]
            CreateItemActionEntity("STAB_" .. action, x, y - 6)
            --if not flag and num == 1 then AddFlagPersistent("stab_spell_acquired") end 
        end
    elseif name == "$animal_boss_meat" then
        if CreateStabSpell("MISERICORDE", x, y-6) then 
            if not flag then AddFlagPersistent("stab_spell_acquired") end
        else
            stab_boost_spell(x, y-6) 
        end
    elseif name == "$animal_boss_dragon" then
        if CreateStabSpell("FIRE", x, y-6) then 
            if not flag then AddFlagPersistent("stab_spell_acquired") end
        else
            stab_boost_spell(x, y-6) 
        end
    elseif name == "$animal_boss_alchemist" then
        if CreateStabSpell("GETAWAY", x, y-6) then 
            if not flag then AddFlagPersistent("stab_spell_acquired") end
        else
            stab_boost_spell(x, y-6) 
        end
    elseif name == "$animal_boss_limbs" then
        if CreateStabSpell("STAB", x, y-6) then 
            if not flag then AddFlagPersistent("stab_spell_acquired") end
        else
            stab_boost_spell(x, y-6) 
        end
    elseif name == "$animal_boss_ghost" then
        if CreateStabSpell("ENGINE", x, y-6) then 
            if not flag then AddFlagPersistent("stab_spell_acquired") end
        else
            stab_boost_spell(x, y-6) 
        end
    elseif name == "$animal_maggot_tiny" then
        if CreateStabSpell("BUFF", x, y-6) then 
            if not flag then AddFlagPersistent("stab_spell_acquired") end
        else
            stab_boost_spell(x, y-6) 
        end
    else
        stab_boost_spell(x, y-6)
    end
end