local fn = vim.fn

local present, impatient = pcall(require, 'impatient')
if present then impatient.enable_profile() end

require'utils.global'
require'options'
require'autocommands'
require'keybindings'

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }

  vim.cmd "packadd packer.nvim"

  require('plugins')
  require('packer').sync()
end

require('plugins')
