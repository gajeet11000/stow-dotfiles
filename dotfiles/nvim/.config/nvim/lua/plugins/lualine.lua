return {
  "nvim-lualine/lualine.nvim",
  cond = not vim.g.vscode,
  dependencies = { "nvim-tree/nvim-web-devicons", },
  opts = {
    options = {
      theme = "auto",
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
  },
}
