-- lua/plugins/completion.lua
return {
	"saghen/blink.cmp",
	version = "*",
	opts = {
		keymap = {
			preset = "default",
			["<CR>"] = { "accept", "fallback" },
		},
		sources = { default = { "lsp", "path", "buffer" } },
	},
}
