local validators = {
    valid_minion_decal = function (unit)
        return unit and HEALTH_ALIVE[unit]
    end,

    valid_barrel_decal = function (prop, valid_states)
        if prop == nil or prop._unit == nil or valid_states == nil then
            return false
        end

        local curr_state = prop:current_state()
        for _, state in ipairs(valid_states) do
            if curr_state == state then
                return true
            end
        end
        return false
    end
}

return validators
