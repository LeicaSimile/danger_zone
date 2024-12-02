return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`danger_zone` encountered an error loading the Darktide Mod Framework.")

		new_mod("danger_zone", {
			mod_script       = "danger_zone/scripts/mods/danger_zone/danger_zone",
			mod_data         = "danger_zone/scripts/mods/danger_zone/danger_zone_data",
			mod_localization = "danger_zone/scripts/mods/danger_zone/danger_zone_localization",
		})
	end,
	packages = {},
}
