local ConfigGunActionInfo_Init_old = ConfigGunActionInfo_Init
function ConfigGunActionInfo_Init(value)
    value.stab_stab_stab = 1
    value.stab_power = 0
    ConfigGunActionInfo_Init_old(value)
end