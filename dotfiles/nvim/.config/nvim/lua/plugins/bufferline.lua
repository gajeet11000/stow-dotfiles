---@diagnostic disable: undefined-global

return {
	"akinsho/bufferline.nvim",
	cond = not vim.g.vscode, -- never load inside VS Code, it doesn't render this
	opts = {
		options = {
			show_buffer_close_icons = true,
			show_close_icon = false,
		},
	},
}
