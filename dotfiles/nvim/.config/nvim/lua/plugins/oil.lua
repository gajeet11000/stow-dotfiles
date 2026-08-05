-- lua/plugins/oil.lua
return {
  "stevearc/oil.nvim",
  ---@module "oil"
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = false,      -- important: don't let it take over netrw/`nvim <dir>` from Snacks
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true, -- no extra prompt for plain renames/creates
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 90,
      max_height = 30,
      border = "rounded",
    },
    keymaps = {
      ["<C-h>"] = false, -- avoid clobbering your window-nav keymaps
      ["<C-l>"] = false,
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-s>"] = "actions.select_split",
      ["q"] = "actions.close",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use this instead if you already have it
  lazy = true,
  cmd = "Oil", -- only loads when you actually invoke it
}
