---@diagnostic disable: undefined-global

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,      -- load before other plugins, since they may check `vim.g.colors_name`
	cond = not vim.g.vscode, -- never load inside VS Code, it doesn't render this
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato", -- latte, frappe, macchiato, mocha
			transparent_background = false,
			integrations = {
				treesitter = true,
				native_lsp = { enabled = true }, -- harmless to leave true even without LSP yet
				lualine = true,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
