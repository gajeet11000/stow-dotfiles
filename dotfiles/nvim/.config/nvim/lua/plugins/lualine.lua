---@diagnostic disable: undefined-global

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" }, -- explicit dependency, forces catppuccin to load first
	cond = not vim.g.vscode,
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true, -- one statusline across all splits, instead of one per window
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { { "filename", path = 1 } }, -- relative path, not just basename
				lualine_x = { "diagnostics", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
