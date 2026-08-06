return {
	"akinsho/bufferline.nvim",
	cond = not vim.g.vscode,
	opts = {
		options = {
			show_buffer_close_icons = true,
			show_close_icon = false,
		},
	},
}
