local ChaosDaemonhostSettings = require("scripts/settings/monster/chaos_daemonhost_settings")
local ExplosionTemplates = require("scripts/settings/damage/explosion_templates")
local MinionBuffTemplates = require("scripts/settings/buff/minion_buff_templates")

-- Thanks to manshako for figuring this out:
local function get_corruption_aura_radius()
    local radius = nil
    local getter = {}
    setmetatable(getter, {
        __index = function()
            local func = debug.getinfo(2).func
            local i = 1
            while true do
                local n, v = debug.getupvalue(func, i)
                if n == "CORRUPTION_AURA_RADIUS" then
                    radius = v
                    break
                elseif not n then
                    break
                end
                i = i + 1
            end
            return { unit = nil }
        end
    })
    MinionBuffTemplates.daemonhost_corruption_aura.interval_func({}, getter)
    return radius
end

local daemonhost_corruption_aura_radius = get_corruption_aura_radius()
return {
    liquid = {
        prop_fire = {
            setting_group = "fire_barrel_explosion",
        },
        renegade_flamer_backpack = {
            setting_group = "scab_flamer_explosion",
        },
        renegade_grenadier_fire_grenade = {
            setting_group = "scab_bomber_grenade",
        },
        cultist_flamer_backpack = {
            setting_group = "tox_flamer_explosion",
        },
        -- cultist_grenadier_gas = {
        --     setting_group = "tox_bomber_gas",
        -- },
    },
    minion = {
        chaos_daemonhost = {
            spawn = {
                radius = ChaosDaemonhostSettings.anger_distances.passive[1].distance,
                setting_group = "daemonhost_spawn",
                validator = "valid_minion_decal",
            },
            buffs = {
                daemonhost_corruption_aura = {
                    radius = daemonhost_corruption_aura_radius,
                    setting_group = "daemonhost_aura",
                    validator = "valid_minion_decal",
                },
            },
        },
        chaos_poxwalker_bomber = {
            spawn = {
                radius = ExplosionTemplates.poxwalker_bomber.radius,
                setting_group = "poxburster_spawn",
                validator = "valid_minion_decal",
            },
        },
        cultist_flamer = {
            spawn = {
                radius = ExplosionTemplates.explosion_settings_cultist_flamer.radius,
                setting_group = "tox_flamer_spawn",
            },
            buffs = {
                cultist_flamer_backpack_damaged = {
                    radius = ExplosionTemplates.explosion_settings_cultist_flamer.radius,
                    setting_group = "tox_flamer_fuse",
                    validator = "valid_minion_decal",
                },
            },
        },
        renegade_flamer = {
            spawn = {
                radius = ExplosionTemplates.explosion_settings_renegade_flamer.radius,
                setting_group = "scab_flamer_spawn",
                validator = "valid_minion_decal",
            },
            buffs = {
                renegade_flamer_backpack_damaged = {
                    radius = ExplosionTemplates.explosion_settings_renegade_flamer.radius,
                    setting_group = "scab_flamer_fuse",
                    validator = "valid_minion_decal",
                },
            },
        },
    },
    prop = {
        explosion = {
            spawn = {
                radius = ExplosionTemplates.explosive_barrel.radius,
                setting_group = "explosive_barrel_spawn",
                validator = "valid_barrel_decal",
            },
            triggered = {
                radius = ExplosionTemplates.explosive_barrel.radius,
                setting_group = "explosive_barrel_fuse",
                validator = "valid_barrel_decal",
            },
        },
        fire = {
            spawn = {
                radius = ExplosionTemplates.fire_barrel.radius,
                setting_group = "fire_barrel_spawn",
                validator = "valid_barrel_decal",
            },
            triggered = {
                radius = ExplosionTemplates.fire_barrel.radius,
                setting_group = "fire_barrel_fuse",
                validator = "valid_barrel_decal",
            },
        },
    },
}
