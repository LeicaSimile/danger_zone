-- Author: LeicaSimile
local mod = get_mod("danger_zone")
local outline_templates = mod:io_dofile("danger_zone/scripts/mods/danger_zone/outline_templates")
local utils = mod:io_dofile("danger_zone/scripts/mods/danger_zone/utils")
local validators = mod:io_dofile("danger_zone/scripts/mods/danger_zone/validators")

local HazardPropSettings = require("scripts/settings/hazard_prop/hazard_prop_settings")
local hazard_state = HazardPropSettings.hazard_state

local decals = mod:persistent_table("hazard_decals")
local source_unit_map = mod:persistent_table("dz_source_unit_map")
local settings_cache = {}
-- Was hoping to find other potential styles. Maybe one day.
local decal_path = "content/levels/training_grounds/fx/decal_aoe_indicator"
local package_path = "content/levels/training_grounds/missions/mission_tg_basic_combat_01"
table.unpack = table.unpack or unpack

----- ## Settings management ## -----
local function get_setting(setting)
    -- Cache settings for quick checks
    local val = settings_cache[setting]
    if val == nil then
        settings_cache[setting] = mod:get(setting)
        val = settings_cache[setting]
    end
    return val
end

local function get_outline_rgba(group_id)
    return get_setting(group_id .. "_colour_red") / 100,
        get_setting(group_id .. "_colour_green") / 100,
        get_setting(group_id .. "_colour_blue") / 100,
        get_setting(group_id .. "_colour_alpha") / 100
end

local function is_enabled(group_id)
    return get_setting(group_id .. "_outline_enabled")
end

local function clear_settings_cache()
    for key, _ in pairs(settings_cache) do
        settings_cache[key] = nil
    end
end


---- ## Rendering outlines ## ----
local function get_decal(template_id, unit, world, radius, ...)
    local validator_args = {...}
    if not Managers.package:has_loaded(package_path) then
		Managers.package:load(package_path, "danger_zone", function()
			get_decal(template_id, unit, world, radius, table.unpack(validator_args))
		end)
		return
	end

    local template = outline_templates.templates[template_id]
    local validator = template.validator
    local setting_group_enabled = template.setting_group_enabled or template.setting_group
    local decal = decals[unit]
    local decal_enabled = is_enabled(setting_group_enabled)
    local decal_valid = validator == nil or validators[validator](...)
    local should_show = decal_enabled and decal_valid
    
    if should_show and (decal == nil or decal.unit == nil) then
        local unit_position = POSITION_LOOKUP[unit]

        -- Create decal unit (based on raindish's NumericUI medipack)
        decal = {
            unit = World.spawn_unit_ex(world, decal_path, nil, unit_position),
            radius = radius or template.radius,
            template_id = template_id,
            setting_group_enabled = setting_group_enabled,
            show = should_show,
            valid = decal_valid,
            validator_args = ...,
            wwise_source_id = nil,
            active = false,
        }

        -- Link decal to unit
        World.link_unit(world, decal.unit, 1, unit, 1)
        decals[unit] = decal
    end

    if decal then
        decal.show = should_show
        decal.valid = decal_valid
    end
    return decal
end

local function draw_circle(decal, radius, template_id)
    if decal.template_id ~= template_id or not decal.active then
        local template = outline_templates.templates[template_id]
        decal.template_id = template_id
        decal.setting_group_enabled = template.setting_group_enabled
        decal.active = true

        -- Set colour
        local red, green, blue, alpha = get_outline_rgba(template.setting_group_colour or template.setting_group)
        local colour = Quaternion.identity()
        Quaternion.set_xyzw(colour, red, green, blue, 0)
        Unit.set_vector4_for_material(decal.unit, "projector", "particle_color", colour, true)

        -- Set opacity
        Unit.set_scalar_for_material(decal.unit, "projector", "color_multiplier", alpha)
    end

    -- Set size
    local diameter = radius * 2
    Unit.set_local_scale(decal.unit, 1, Vector3(diameter, diameter, 1))
    decal.radius = radius
end

local function destroy_decal(unit, temporary)
	local decal = decals[unit]
	if decal then
        decal.active = false
        if Unit.is_valid(decal.unit) then
            World.destroy_unit(Unit.world(decal.unit), decal.unit)
            decal.unit = nil
        end
        if not temporary then
            if decal.wwise_source_id then
                source_unit_map[decal.wwise_source_id] = nil
            end
            decals[unit] = nil
        end
	end
end

local function display_all_valid_decals(enabled_id)
    for unit, val in pairs(decals) do
        local world = Unit.is_valid(unit) and Unit.world(unit)
        local decal = get_decal(val.template_id, unit, world, val.radius, val.validator_args)
        if enabled_id == nil or (decal and decal.setting_group_enabled == enabled_id) then
            if decal and decal.show then
                draw_circle(decal, decal.radius, decal.template_id)
            else
                local temporary = decal and decal.valid
                destroy_decal(unit, temporary)
            end
        end
    end
end

local function destroy_all_decals(enabled_id, temporary)
    for unit, val in pairs(decals) do
        if enabled_id == nil or val.setting_group_enabled == enabled_id then
            destroy_decal(unit, temporary)
        end
    end
end

local function check_active_decals()
    local game_state = Managers.presence and Managers.presence._current_game_state_name
    local game_mode = Managers.state.game_mode and Managers.state.game_mode:game_mode_name()
    if game_state == "StateGameplay" and game_mode ~= "hub" then
        -- Display any outlines previously active as appropriate.
        display_all_valid_decals()
    else
        destroy_all_decals()
    end
end


---- ## Hooks ## ----
mod.on_setting_changed = function(setting_id)
    local new_val = mod:get(setting_id)
    settings_cache[setting_id] = new_val

    -- Show any valid decals related to this setting
    local match = "_outline_enabled"
    if utils.endswith(setting_id, match) and mod:is_enabled() then
        local group_id = utils.strip_end(setting_id, match)
        if new_val then
            display_all_valid_decals(group_id)
        else
            destroy_all_decals(group_id, true)
        end
    end
end

mod.on_enabled = function(_)
    clear_settings_cache()
    if not Managers.package:has_loaded(package_path) then
        Managers.package:load(package_path, "danger_zone", function()
            check_active_decals()
        end)
        return
    else
        check_active_decals()
    end
end

mod.on_disabled = function(_)
    -- Hide any active outlines
    destroy_all_decals(nil, true)
end

mod:hook_safe("UIManager", "cb_on_game_state_change", function()
    destroy_all_decals()
end)


---- ## Liquid Area hooks ## ----
local function on_liquid_spawn(self, radius)
    local template_id = outline_templates.liquid[self._template_name]
    local template = outline_templates.templates[template_id]

    if template then
        local decal = get_decal(template_id, self._unit, self._world, radius)
        if decal and decal.show then
            draw_circle(decal, radius, template_id)
        end
    end
end

mod:hook_safe("LiquidAreaExtension", "init", function(self, _, _, extension_init_data)
    self._template_name = extension_init_data.template.name
end)

mod:hook_safe("LiquidAreaExtension", "_calculate_broadphase_size", function (self)
    on_liquid_spawn(self, self._broadphase_radius)
end)

mod:hook_safe("LiquidAreaExtension", "destroy", function (self)
    destroy_decal(self._unit)
end)

mod:hook_safe("HuskLiquidAreaExtension", "init", function(self, _, _, extension_init_data)
    self._template_name = extension_init_data.template.name
end)

mod:hook_safe("HuskLiquidAreaExtension", "_calculate_liquid_size", function(self)
    on_liquid_spawn(self, self._liquid_radius)
end)

mod:hook_safe("HuskLiquidAreaExtension", "destroy", function(self)
    destroy_decal(self._unit)
end)


---- ## Enemy event hooks ## ----
local function on_minion_spawn(extension_init_context, unit)
    local unit_data_ext = ScriptUnit.extension(unit, "unit_data_system")
    local breed = unit_data_ext and unit_data_ext:breed()
    local breed_template = breed and outline_templates.minion[breed.name]
    local template_id = breed_template and breed_template.spawn
    local template = outline_templates.templates[template_id]

    if template then
        local world = extension_init_context.world
        local decal = get_decal(template_id, unit, world, template.radius, unit)
        if decal and decal.show then
            draw_circle(decal, template.radius, template_id)
        else
            local temporary = decal and decal.valid
            destroy_decal(unit, temporary)
        end
    end
end

mod:hook_safe("HealthExtension", "init", function(_, extension_init_context, unit)
    on_minion_spawn(extension_init_context, unit)
end)

mod:hook_safe("HealthExtension", "kill", function(self)
    local unit = self._unit
    destroy_decal(unit)
end)

mod:hook_safe("HuskHealthExtension", "init", function(_, extension_init_context, unit)
    on_minion_spawn(extension_init_context, unit)
end)

mod:hook_safe("MinionDeathManager", "set_dead", function(_, unit)
    destroy_decal(unit)
end)

mod:hook_safe("MinionSpawnManager", "unregister_unit", function(_, unit)
    destroy_decal(unit)
end)

mod:hook_safe("UnitSpawnerManager", "mark_for_deletion", function(_, unit)
    destroy_decal(unit)
end)

mod:hook_safe("DialogueExtension", "extensions_ready", function (self, _, unit)
    local breed_template = outline_templates.minion[self._context.breed_name]
    if breed_template and breed_template.set_wwise_source_id then
        source_unit_map[self._wwise_source_id] = unit
    end
end)

mod:hook_safe("WwiseWorld", "set_source_parameter", function(_, source_id, param, value)
    if param == "daemonhost_stage" then
        local stages = outline_templates.minion.chaos_daemonhost.stages
        local template_id = stages[value]
        local template = outline_templates.templates[template_id]

        if template then
            local unit = source_unit_map[source_id]
            local world = Unit.is_valid(unit) and Unit.world(unit)
            local decal = get_decal(template_id, unit, world, template.radius, unit)
            if decal then
                decal.wwise_source_id = source_id
                if decal.show then
                    draw_circle(decal, template.radius, template_id)
                end
            end
            if not (decal and decal.valid) then
                destroy_decal(unit)
            end
        end
    end
end)

mod:hook_safe("Buff", "init", function (_, context, template)
    local breed_template = context.breed and outline_templates.minion[context.breed.name]
    local template_id = breed_template and breed_template.buffs and breed_template.buffs[template.name]
    local template = outline_templates.templates[template_id]

    if template then
        local unit = context.unit
        local world = Unit.is_valid(unit) and Unit.world(unit)
        local decal = get_decal(template_id, unit, world, template.radius, unit)
        if decal and decal.show then
            draw_circle(decal, template.radius, template_id)
        else
            local temporary = decal and decal.valid
            destroy_decal(unit, temporary)
        end
    end
end)


---- ## Barrel event hooks ## ----
mod:hook_safe("HazardPropExtension", "set_content", function(self, content)
    local prop_template = outline_templates.prop[content]
    local template_id = prop_template and prop_template.spawn
    local template = outline_templates.templates[template_id]

    if template then
        local unit = self._unit
        local world = self._world
        local decal = get_decal(template_id, unit, world, template.radius,
            self, {hazard_state.idle, hazard_state.triggered}
        )
        if decal and decal.show then
            draw_circle(decal, template.radius, template_id)
        else
            local temporary = decal and decal.valid
            destroy_decal(unit, temporary)
        end
    end
end)

mod:hook_safe("HazardPropExtension", "set_current_state", function(self, state)
    local prop_template = outline_templates.prop[self._content]
    local template_id = prop_template and prop_template.triggered
    local template = outline_templates.templates[template_id]

	if template then
        local unit = self._unit
        local world = self._world
        if state == hazard_state.triggered then
            local decal = get_decal(template_id, unit, world, template.radius,
                self, {hazard_state.triggered}
            )
            if decal and decal.show then
                draw_circle(decal, template.radius, template_id)
            else
                local temporary = decal and decal.valid
                destroy_decal(unit, temporary)
            end
        elseif state == hazard_state.exploding or state == hazard_state.broken then
            destroy_decal(unit)
        end
    end
end)
