return {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
        require('github-theme').setup {
            darken = {                 -- Darken floating windows and sidebar-like windows
                floats = false,
                sidebars = {
                    enabled = false,
                },
            },
            palletes = {
                all = {
                }
            },
            options = {
                transparent = true,
            },
            groups = {
                all = {
                    NoicePopup = { bg = 'NONE' }
                },
            },
        }

        vim.cmd('colorscheme github_dark')
    end,
}
