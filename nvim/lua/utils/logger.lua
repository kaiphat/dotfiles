local ok, log = pcall(require, 'plenary.log')

local M = {}

if ok then

  M.logger = log.new({
    level = "info"
  })

  M.log = function(...)
   M.logger.info(...)
  end

end

return M
