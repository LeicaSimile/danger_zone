local validators = {
    valid_minion_decal = function (unit)
        local valid = Unit.is_valid(unit) and HEALTH_ALIVE[unit]
        return valid
    end,

    valid_barrel_decal = function (prop, valid_states)
        if prop == nil or not Unit.is_valid(prop._unit) then
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
