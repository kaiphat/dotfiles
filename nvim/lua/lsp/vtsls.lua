-- TODO
return function(lsp, opts)
	-- opts:expand {
	-- }

    opts:add_on_attach_hook(function (client)
    end)
    -- { '<leader>ti', ':TSToolsAddMissingImports<cr>' },
    -- { '<leader>tr', ':TSToolsRenameFile<cr>' },
    -- { '<leader>td', ':TSToolsRemoveUnusedImports<cr>' },
    -- { '<leader>to', ':TSToolsOrganizeImports<cr>' },

	lsp.vtsls.setup(opts:to_server_opts())
end
