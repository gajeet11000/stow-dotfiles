return {
	"chrisgrieser/nvim-spider",
  lazy = true,
	keys = {
		{ "W", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
		{ "E", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
		{ "B", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
		{ "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
	},
}
