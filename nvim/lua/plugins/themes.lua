return {
  {
    dir = '../theme.lua',
    enabled = dark_theme_enabled(),
    config = function ()
      require('theme')
    end
  },
  {
    'projekt0n/github-nvim-theme',
    enabled = not dark_theme_enabled(),
    config = function()
      require('github-theme').setup {}

      vim.cmd 'colorscheme github_light_high_contrast'
    end,
  },
}
