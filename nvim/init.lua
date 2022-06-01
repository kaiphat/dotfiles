local fn = vim.fn

local function check_packer()
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }

    vim.cmd "packadd packer.nvim"

    require 'plugins'

    require('packer').sync()
  end
end

-- LOADING --
require 'impatient'
require 'utils.global'
require 'options'
require 'autocommands'
require 'keybindings'

check_packer()

require 'plugins'
