_G.merge = function(...)
    local result = {}
    local args = { ... }

    for _, t in ipairs(args) do
        for key, value in pairs(t) do
            result[key] = value
        end
    end

    return result
end
