-- lua/plugins/lsp.lua

return {
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		opts = { ensure_installed = { "lua_ls" } }, -- jdtls handled separately, below
	},
	"neovim/nvim-lspconfig",
}
