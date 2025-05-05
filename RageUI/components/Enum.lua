---
--- @author Dylan MALANDAIN
--- @version 2.0.0
--- @since 2020
---
--- RageUI Is Advanced UI Libs in LUA for make beautiful interface like RockStar GAME.
--- @see RageUI
---

---@class Enum
local enums = {
    __index = function(table, key)
        if rawget(table.enums, key) then
            return key
        end
    end
}

---Enum
---@param t table
---@return Enum
function RageUI.Enum(t)
    local e = { enums = t }
    return setmetatable(e, enums)
end
