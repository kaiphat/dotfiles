local disabled_plugins = {
	'2html_plugin',
	'getscript',
	'getscriptPlugin',
	'gzip',
	'logipat',
	'netrw',
	'netrwPlugin',
	'netrwSettings',
	'netrwFileHandlers',
	'matchit',
	'tar',
	'tarPlugin',
	'rrhelper',
	'spellfile_plugin',
	'vimball',
	'vimballPlugin',
	'zip',
	'zipPlugin',
	'fzf',
	'health',
	'tohtml',
	'tutor',
}

for _, plugin in ipairs(disabled_plugins) do
	vim.g['loaded_' .. plugin] = 1
end
