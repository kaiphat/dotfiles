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
                },
            },
        }

        vim.cmd('colorscheme github_dark')
    end,
}
