return {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
        require('github-theme').setup {
            palletes = {
                all = {
                }
            },
            options = {
                transparent = true,
            },
            groups = {
                all = {
                    NoicePopupmenuSelected = { bg = 'bg2' },
                    MatchParen = { bg = 'bg2' },
                    IncSearch = { bg = 'bg2' },
                    MiniTrailspace = { bg = 'bg2' },
                },
            },
        }

        local themes = {
            github_light_tritanopia = 'github_light_tritanopia',
            github_light_default = 'github_light_default',
            github_light_high_contrast = 'github_light_high_contrast',
            github_light_colorblind = 'github_light_colorblind',
        }

        vim.cmd('colorscheme ' .. themes.github_light_high_contrast)
    end,
}
