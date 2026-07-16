__.add_plugin {
	'ryanmab/onoma.nvim',
	enabled = false,
	version = vim.version.range '*',
	opts = {
		picker = { 'snacks' },
	},
}

-- vim.api.nvim_create_autocmd('PackChanged', {
-- 	callback = function(ev)
-- 		local name, kind = ev.data.spec.name, ev.data.kind
-- 		if name == 'onoma.nvim' and (kind == 'install' or kind == 'update') then
-- 			if not ev.data.active then
-- 				vim.cmd.packadd 'onoma.nvim'
-- 			end
--
-- 			-- Important to download the bridge for the checked out tag
-- 			require('onoma.bridge.download').download_bridge()
-- 		end
-- 	end,
-- })
