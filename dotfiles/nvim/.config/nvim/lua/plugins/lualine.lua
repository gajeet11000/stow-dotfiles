
return { 
  'nvim-lualine/lualine.nvim', 
  opts = {
    options = {
      globalstatus = true, -- one statusline across all splits, instead of one per window
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff" },
      lualine_c = { { "filename", path = 1 } }, -- relative path, not just basename
      lualine_x = {
        "diagnostics",
        "filetype",
        function()
          return require("auto-session.lib").current_session_name(true)
        end,
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
