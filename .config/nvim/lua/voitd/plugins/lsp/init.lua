return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", config = true },
			"mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", config = { automatic_installation = true } },
			"hrsh7th/cmp-nvim-lsp",
		},
		---@type lspconfig.options
		servers = nil,
		config = function(plugin)
			-- setup formatting and keymaps
			require("voitd.util").on_attach(function(client, buffer)
				require("voitd.plugins.lsp.format").on_attach(client, buffer)
				require("voitd.plugins.lsp.keymaps").on_attach(client, buffer)
			end)

			-- diagnostics
			for name, icon in pairs(require("voitd.config.icons").diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end
			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			})

			-- lspconfig
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			---@type lspconfig.options
			local servers = plugin.servers or require("voitd.plugins.lsp.servers")
			for server, opts in pairs(servers) do
				opts.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
				require("lspconfig")[server].setup(opts)
			end
		end,
	},

	-- formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
		config = function()
			local nls = require("null-ls")
			nls.setup({
				sources = {
					nls.builtins.code_actions.gitsigns,
					nls.builtins.formatting.eslint_d,
					nls.builtins.formatting.prettierd,
					nls.builtins.formatting.stylua,
					nls.builtins.diagnostics.flake8,
				},
			})
		end,
	},

	-- cmdline tools and lsp servers
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		ensure_installed = {
			"stylua",
			"shellcheck",
			"shfmt",
			"prettierd",
			"eslint_d",
			"emmet-ls",
			"css-lsp",
			"html-lsp",
			"tailwindcss-language-server",
			"typescript-language-server",
			"vue-language-server",
		},
		config = function(plugin)
			require("mason").setup()
			local mr = require("mason-registry")
			for _, tool in ipairs(plugin.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},
}
