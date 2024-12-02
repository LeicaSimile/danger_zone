local mod = get_mod("danger_zone")
local version = "1.0.0"
local utils = mod:io_dofile("danger_zone/scripts/mods/danger_zone/utils")
local init_loc = {
	mod_name = {
		en = "Danger Zone",
	},
	mod_description = {
		en = "Shows the range for area of effect hazards like fire and explosions. Version: " .. version,
	},

	area_effects_group = {
		en = "Area Effect Outlines",
	},
	fire_barrel_explosion_outline_enabled = {
		en = "Barrel Fire"
	},
	fire_barrel_explosion_outline_enabled_tooltip = {
		en = "Show outline around barrel fire",
	},
	scab_bomber_grenade_outline_enabled = {
		en = "Scab Bomber Grenade",
	},
	scab_bomber_grenade_outline_enabled_tooltip = {
		en = "Show outline around the fire left by a Scab Bomber's grenade",
	},
	tox_bomber_gas_outline_enabled = {
		en = "Tox Bomber Gas",
	},
	tox_bomber_gas_outline_enabled_tooltip = {
		en = "Show outline around the gas left by a Tox Bomber's grenade",
	},
	scab_flamer_explosion_outline_enabled = {
		en = "Scab Flamer Explosion"
	},
	scab_flamer_explosion_outline_enabled_tooltip = {
		en = "Show outline around the fire left by a Scab Flamer explosion"
	},
	tox_flamer_explosion_outline_enabled = {
		en = "Tox Flamer Explosion",
	},
	tox_flamer_explosion_outline_enabled_tooltip = {
		en = "Show outline around the fire left by a Tox Flamer explosion"
	},

	explosive_barrel_effects_group = {
		en = "Explosive Barrel Explosion Radius",
	},
	explosive_barrel_spawn_outline_enabled = {
		en = "Show when spawned",
	},
	explosive_barrel_spawn_outline_enabled_tooltip = {
		en = "Show barrel explosion radius when barrel spawns in",
	},
	explosive_barrel_fuse_outline_enabled = {
		en = "Show when hit",
	},
	explosive_barrel_fuse_outline_enabled_tooltip = {
		en = "Show barrel explosion radius when barrel is about to explode",
	},

	fire_barrel_effects_group = {
		en = "Fire Barrel Explosion Radius",
	},
	fire_barrel_spawn_outline_enabled = {
		en = "Show when spawned",
	},
	fire_barrel_spawn_outline_enabled_tooltip = {
		en = "Show barrel explosion radius when barrel spawns in",
	},
	fire_barrel_fuse_outline_enabled = {
		en = "Show when hit",
	},
	fire_barrel_fuse_outline_enabled_tooltip = {
		en = "Show barrel explosion radius when barrel is about to explode",
	},

	daemonhost_effects_group = {
		en = "Daemonhost Proximity Radius",
	},
	daemonhost_spawn_outline_enabled = {
		en = "Show aggro radius",
	},
	daemonhost_spawn_outline_enabled_tooltip = {
		en = "Show area where player movement will start to wake a sleeping Daemonhost",
	},
	daemonhost_aura_outline_enabled = {
		en = "Show corruption aura radius",
	},
	daemonhost_aura_outline_enabled_tooltip = {
		en = "Show area where players near aggressive Daemonhost will take corruption damage over time",
	},

	poxburster_effects_group = {
		en = "Poxburster Explosion Radius",
	},
	poxburster_spawn_outline_enabled = {
		en = "Show when spawned",
	},
	poxburster_spawn_outline_enabled_tooltip = {
		en = "Show Poxburster explosion radius",
	},

	scab_flamer_effects_group = {
		en = "Scab Flamer Explosion Radius",
	},
	scab_flamer_spawn_outline_enabled = {
		en = "Show when spawned",
	},
	scab_flamer_spawn_outline_enabled_tooltip = {
		en = "Show Scab Flamer explosion radius when they spawn",
	},
	scab_flamer_fuse_outline_enabled = {
		en = "Show when set to explode",
	},
	scab_flamer_fuse_outline_enabled_tooltip = {
		en = "Show Scab Flamer explosion radius when Scab Flamer is set to explode upon death",
	},

	tox_flamer_effects_group = {
		en = "Tox Flamer Explosion Radius",
	},
	tox_flamer_spawn_outline_enabled = {
		en = "Show when spawned",
	},
	tox_flamer_spawn_outline_enabled_tooltip = {
		en = "Show Tox Flamer explosion radius when they spawn",
	},
	tox_flamer_fuse_outline_enabled = {
		en = "Show when set to explode",
	},
	tox_flamer_fuse_outline_enabled_tooltip = {
		en = "Show Tox Flamer explosion radius when Tox Flamer is set to explode upon death",
	},
}
local function add_group_loc(group_id, table)
	table[group_id .. "_colour_red"] = {
		en = "Red (%%)",
	}
	table[group_id .. "_colour_green"] = {
		en = "Green (%%)",
	}
	table[group_id .. "_colour_blue"] = {
		en = "Blue (%%)",
	}
	table[group_id .. "_colour_alpha"] = {
		en = "Opacity (%%)",
	}
end

local localizations = {}
for key, val in pairs(init_loc) do
	localizations[key] = val
	local match = "_outline_enabled"
	if utils.endswith(key, match) then
		add_group_loc(utils.strip_end(key, match), localizations)
	end
end

return localizations
