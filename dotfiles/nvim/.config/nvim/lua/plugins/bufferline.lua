return {
  'akinsho/bufferline.nvim',
  lazy = false,
  opts = {
    options = {
      indicator = {
        style = "underline",
      },
    },
  },
  keys = {
    { "<S-h>",      "<cmd>BufferLineCyclePrev<CR>",   desc = "Prev Buffer" },
    { "<S-l>",      "<cmd>BufferLineCycleNext<CR>",   desc = "Next Buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close Other Buffers" },
  },
}
