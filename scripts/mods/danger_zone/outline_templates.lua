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

local function get_highest_alert_ticking_radius()
    local radius = 1
    for _, v in ipairs(ChaosDaemonhostSettings.anger_distances.not_passive) do
        if v.distance > radius and v.tick then
            radius = v.distance
        end
    end
    return radius
end

local daemonhost_corruption_aura_radius = get_corruption_aura_radius()
local highest_alert_ticking_radius = get_highest_alert_ticking_radius()
local templates = {
    fire_barrel_explosion = {
        setting_group = "fire_barrel_explosion",
    },
    scab_flamer_explosion = {
        setting_group = "scab_flamer_explosion",
    },
    scab_bomber_grenade = {
        setting_group = "scab_bomber_grenade",
    },
    tox_flamer_explosion = {
        setting_group = "tox_flamer_explosion",
    },
    -- tox_bomber_gas = {
    --     setting_group = "tox_bomber_gas",
    -- },
    daemonhost_spawn = {
        radius = ChaosDaemonhostSettings.anger_distances.passive[1].distance,
        setting_group = "daemonhost_spawn",
        validator = "valid_minion_decal",
    },
    daemonhost_alert1 = {
        radius = highest_alert_ticking_radius,
        setting_group = "daemonhost_alert1",
        setting_group_enabled = "daemonhost_spawn",
        setting_group_colour = "daemonhost_alert1",
        validator = "valid_minion_decal",
    },
    daemonhost_alert2 = {
        radius = highest_alert_ticking_radius,
        setting_group = "daemonhost_alert2",
        setting_group_enabled = "daemonhost_spawn",
        setting_group_colour = "daemonhost_alert2",
        validator = "valid_minion_decal",
    },
    daemonhost_alert3 = {
        radius = highest_alert_ticking_radius,
        setting_group = "daemonhost_alert3",
        setting_group_enabled = "daemonhost_spawn",
        setting_group_colour = "daemonhost_alert3",
        validator = "valid_minion_decal",
    },
    daemonhost_aura = {
        radius = daemonhost_corruption_aura_radius,
        setting_group = "daemonhost_aura",
        validator = "valid_minion_decal",
    },
    poxburster_spawn = {
        radius = ExplosionTemplates.poxwalker_bomber.radius,
        setting_group = "poxburster_spawn",
        validator = "valid_minion_decal",
    },
    tox_flamer_spawn = {
        radius = ExplosionTemplates.explosion_settings_cultist_flamer.radius,
        setting_group = "tox_flamer_spawn",
    },
    tox_flamer_fuse = {
        radius = ExplosionTemplates.explosion_settings_cultist_flamer.radius,
        setting_group = "tox_flamer_fuse",
        validator = "valid_minion_decal",
    },
    scab_flamer_spawn = {
        radius = ExplosionTemplates.explosion_settings_renegade_flamer.radius,
        setting_group = "scab_flamer_spawn",
        validator = "valid_minion_decal",
    },
    scab_flamer_fuse = {
        radius = ExplosionTemplates.explosion_settings_renegade_flamer.radius,
        setting_group = "scab_flamer_fuse",
        validator = "valid_minion_decal",
    },
    explosive_barrel_spawn = {
        radius = ExplosionTemplates.explosive_barrel.radius,
        setting_group = "explosive_barrel_spawn",
        validator = "valid_barrel_decal",
    },
    explosive_barrel_fuse = {
        radius = ExplosionTemplates.explosive_barrel.radius,
        setting_group = "explosive_barrel_fuse",
        validator = "valid_barrel_decal",
    },
    fire_barrel_spawn = {
        radius = ExplosionTemplates.fire_barrel.radius,
        setting_group = "fire_barrel_spawn",
        validator = "valid_barrel_decal",
    },
    fire_barrel_fuse = {
        radius = ExplosionTemplates.fire_barrel.radius,
        setting_group = "fire_barrel_fuse",
        validator = "valid_barrel_decal",
    },
}

return {
    templates = templates,
    liquid = {
        prop_fire = "fire_barrel_explosion",
        renegade_flamer_backpack = "scab_flamer_explosion",
        renegade_grenadier_fire_grenade = "scab_bomber_grenade",
        cultist_flamer_backpack = "tox_flamer_explosion",
        -- cultist_grenadier_gas = "tox_bomber_gas",
    },
    minion = {
        chaos_daemonhost = {
            set_wwise_source_id = true,
            spawn = "daemonhost_spawn",
            stages = {
                [ChaosDaemonhostSettings.stages.agitated] = "daemonhost_alert1",
                [ChaosDaemonhostSettings.stages.disturbed] = "daemonhost_alert2",
                [ChaosDaemonhostSettings.stages.about_to_wake_up] = "daemonhost_alert3",
            },
            buffs = {
                daemonhost_corruption_aura = "daemonhost_aura",
            },
        },
        chaos_poxwalker_bomber = {
            spawn = "poxburster_spawn",
        },
        cultist_flamer = {
            spawn = "tox_flamer_spawn",
            buffs = {
                cultist_flamer_backpack_damaged = "tox_flamer_fuse",
            },
        },
        renegade_flamer = {
            spawn = "scab_flamer_spawn",
            buffs = {
                renegade_flamer_backpack_damaged = "scab_flamer_fuse",
            },
        },
    },
    prop = {
        explosion = {
            spawn = "explosive_barrel_spawn",
            triggered = "explosive_barrel_fuse",
        },
        fire = {
            spawn = "fire_barrel_spawn",
            triggered = "fire_barrel_fuse",
        },
    },
}
