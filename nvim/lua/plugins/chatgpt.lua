local key = os.getenv 'CHATGPT_API_KEY'

return {
  {
    'jackmort/chatgpt.nvim',
    config = function()
      local chat = require 'chatgpt'

      chat.setup {
        api_key_cmd = 'echo ' .. key,

        popup_window = {
          win_options = {
            foldcolumn = '0',
          },
        },

        system_window = {
          win_options = {
            foldcolumn = '0',
          },
        },
      }
    end,
  },
}
