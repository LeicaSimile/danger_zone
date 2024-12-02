local utils = {
    endswith = function (str_var, suffix)
        return string.sub(str_var, -#suffix) == suffix
    end,

    strip_end = function (str_var, end_str)
        -- Return str_var without end_str at the end
        return string.sub(str_var, 1, -#end_str - 1)
    end
}

return utils
