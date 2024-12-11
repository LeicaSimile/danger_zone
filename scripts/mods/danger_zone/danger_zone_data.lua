local mod = get_mod("danger_zone")

local function get_colour_widgets(group_id, default_colour)
	local widgets = {
		{
			setting_id = group_id .. "_colour_red",
			type = "numeric",
			default_value = default_colour[1],
			range = {0, 100},
		},
		{
			setting_id = group_id .. "_colour_green",
			type = "numeric",
			default_value = default_colour[2],
			range = {0, 100},
		},
		{
			setting_id = group_id .. "_colour_blue",
			type = "numeric",
			default_value = default_colour[3],
			range = {0, 100},
		},
		{
			setting_id = group_id .. "_colour_alpha",
			type = "numeric",
			default_value = default_colour[4],
			range = {1, 100},
		},
	}
	return widgets
end

local function add_setting(group, group_id, default_colour, default_enabled, colour_groups)
	if default_enabled == nil then
		default_enabled = true
	end

	local colour_widgets = get_colour_widgets(group_id, default_colour)
	if colour_groups then
		for _, v in ipairs(colour_groups) do
			for _, w in ipairs(get_colour_widgets(v[1], v[2])) do
				table.insert(colour_widgets, w)
			end
		end
	end

	local sub_widgets_group = group.sub_widgets
	table.insert(sub_widgets_group, {
		setting_id = group_id .. "_outline_enabled",
		type = "checkbox",
		default_value = default_enabled,
		tooltip = group_id .. "_outline_enabled_tooltip",
		sub_widgets = colour_widgets,
	})
end

local group_names = {
	"area_effects",
	"explosive_barrel_effects",
	"fire_barrel_effects",
	"daemonhost_effects",
	"poxburster_effects",
	"scab_flamer_effects",
	"tox_flamer_effects",
}
local groups = {}
for _, name in ipairs(group_names) do
	groups[name] = {
		setting_id = name .. "_group",
		type = "group",
		sub_widgets = {},
	}
end
add_setting(groups.area_effects, "fire_barrel_explosion", {80, 20, 0, 100})
add_setting(groups.area_effects, "scab_bomber_grenade", {100, 0, 0, 100})
--add_setting(groups.area_effects, "tox_bomber_gas", {100, 0, 0, 20})
add_setting(groups.area_effects, "scab_flamer_explosion", {80, 20, 0, 100})
add_setting(groups.area_effects, "tox_flamer_explosion", {100, 0, 0, 100})

add_setting(groups.explosive_barrel_effects, "explosive_barrel_spawn", {30, 25, 0, 10}, false)
add_setting(groups.explosive_barrel_effects, "explosive_barrel_fuse", {30, 25, 0, 50})

add_setting(groups.fire_barrel_effects, "fire_barrel_spawn", {30, 25, 0, 10}, false)
add_setting(groups.fire_barrel_effects, "fire_barrel_fuse", {30, 25, 0, 50})

add_setting(groups.daemonhost_effects, "daemonhost_spawn", {30, 50, 0, 10}, true, {
	{"daemonhost_alert1", {30, 50, 0, 10}},
	{"daemonhost_alert2", {35, 20, 5, 10}},
	{"daemonhost_alert3", {40, 5, 10, 10}},
})
add_setting(groups.daemonhost_effects, "daemonhost_aura", {30, 50, 0, 10})

add_setting(groups.poxburster_effects, "poxburster_spawn", {40, 5, 10, 10})

add_setting(groups.scab_flamer_effects, "scab_flamer_spawn", {30, 25, 0, 10}, false)
add_setting(groups.scab_flamer_effects, "scab_flamer_fuse", {30, 25, 0, 50})

add_setting(groups.tox_flamer_effects, "tox_flamer_spawn", {30, 25, 0, 10}, false)
add_setting(groups.tox_flamer_effects, "tox_flamer_fuse", {30, 25, 0, 50})

local haz_widgets = {}
for _, val in ipairs(group_names) do
	-- Make sure to insert from top to bottom as listed in group_names
	table.insert(haz_widgets, groups[val])
end

return {
	name = mod:localize("mod_name"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = haz_widgets,
	}
}
