-- lua/plugins/completion.lua
return {
  "saghen/blink.cmp",
  version = "1.*", -- stable branch
  opts = {
    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
    },
    sources = { default = { "lsp", "path", "buffer" } },
  },
}
