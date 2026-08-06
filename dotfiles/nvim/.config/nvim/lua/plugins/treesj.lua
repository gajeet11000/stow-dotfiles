return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({--[[ your config ]]})
    vim.keymap.set("n", '<leader>fm', require("treesj").toggle, { desc = "Toggle list expansion"})
  end,
}
