return {
	"chrisgrieser/nvim-spider",
	lazy = true,
	keys = {
		{ "W", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" }, desc = "Spider-w (subword)" },
		{ "E", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" }, desc = "Spider-e (subword)" },
		{ "B", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" }, desc = "Spider-b (subword)" },
	},
}
