local M = {}

M.logger = require("plenary.log").new({
  level = "info"
})

M.log = function(...)
 M.logger.info(...)
end

return M
