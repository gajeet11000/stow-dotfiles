return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },

  init = function()
    vim.g.no_plugin_maps = true -- avoid built-in ftplugin mapping conflicts
  end,

  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = { lookahead = true },
    })

    local map = vim.keymap.set

    local select = require("nvim-treesitter-textobjects.select")
    map({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end)
    map({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end)
    map({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end)
    map({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end)
    map({ "x", "o" }, "as", function() select.select_textobject("@local.scope", "locals") end)

    local move = require("nvim-treesitter-textobjects.move")
    map({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end)
    map({ "n", "x", "o" }, "]]", function() move.goto_next_start("@function.outer", "textobjects") end)
    map({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end)
    map({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@function.outer", "textobjects") end)
  end,
}
