return {
  "rmagatti/auto-session",
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~", "~/Projects", "~/Downloads", "/" },
    session_lens = {
      picker = "snacks",
      mappings = {
        delete_session = { "n", "<C-d>" },
      },
    }
  },

  keys = {
    { "<leader>ls", "<cmd>AutoSession search<CR>", desc = "Session search" },
  },
}
