
---@class profile
---@field name string -- your editor name
---@field author? string
---@field version? string
---@field license? string
local m = {
  name = "BIGMAN",
}
m = setmetatable({}, { __index = m })

---@param opts? profile
function m.setup(opts)
  m = vim.tbl_deep_extend("force", m, opts or {})
end

return m
