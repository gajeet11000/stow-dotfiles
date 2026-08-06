-- lua/plugins/completion.lua
return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
    },
    sources = { default = { "lsp", "path", "buffer" } },
  },
}
