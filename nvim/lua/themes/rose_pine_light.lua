return {
    'rose-pine/neovim',
    priority = 1000,
    lazy = false,
    name = 'rose-pine',
    config = function()
        local rp = require 'rose-pine'

        rp.setup {
            variant = 'dawn',
            dark_variant = 'dawn',
            dim_nc_background = false,
            disable_background = true,
            disable_float_background = true,

            highlight_groups = {
                MiniCursorword = { underline = false, bg = 'foam', blend = 30 },
                GitSignsAdd = { bg = 'none' },
                GitSignsChange = { bg = 'none' },
                GitSignsDelete = { bg = 'none' },
                ['@variable'] = { italic = false },
                ['@lsp.type.property'] = { italic = false },
                ['@property.typescript'] = { italic = false },
            },
        }

        vim.cmd 'colorscheme rose-pine-dawn'
    end,
}