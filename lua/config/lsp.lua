require("config.lsp_keymaps")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


local mason_lspconfig = require 'mason-lspconfig'

local M={}

--local servers = require("config.servers")

function M.setup()

	require('mason').setup()

	mason_lspconfig.setup{
		ensure_installed = vim.tbl_keys(require("config.servers")),
	}

	mason_lspconfig.setup_handlers {
		function(server_name)
			require('lspconfig')[server_name].setup{
				capabilities = capabilities,
				on_attach = on_attach,
				settings = require("config.servers")[server_name],
			}
		end,
	}

	--require('fidget').setup()
end

return M