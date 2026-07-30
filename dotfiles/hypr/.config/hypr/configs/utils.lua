local vars = require("configs.variables")

local M = {}

---@param offset number
---@return nil
function M.zoom(offset)
    local MAX_ZOOM = 3
    local MIN_ZOOM = 1
    local ZOOM_TOGGLE_FACTOR = 1.25

    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end

function M.scratchpad_cmd(opts)
    return string.format(
        '%s identifier="%s" scratch="%s" exec="%s"',
        vars.SCRATCHPAD, opts.identifier, opts.scratch, opts.exec
    )
end

return M