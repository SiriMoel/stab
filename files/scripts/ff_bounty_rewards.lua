local stab_rewards = {
    {
        id = "stab_spell",
        chance = 1.1,
        spawn_func = function(x, y) 
            SetRandomSeed(x, y)
            local num = Random(1, 4)
            local opts = {}
            if num == 1 then
                local possible_opts = {"STAB", "FIRE", "MISERICORDE", "GETAWAY", "BUFF", "ENGINE"}
                for i,v in ipairs(possible_opts) do
                    if ModSettingGet("stab.spell_" .. v) then
                        table.insert(opts, v)
                    end
                end
            else
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
            end
        end,
    },
}

for i,v in ipairs(stab_rewards) do
    table.insert(bounty_rewards, v)
end