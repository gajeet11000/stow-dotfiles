local select = function(query, group)
  return function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, group)
  end
end

local move = function(method, query, group)
  return function()
    require("nvim-treesitter-textobjects.move")[method](query, group)
  end
end

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",

  opts = {
    select = {
      lookahead = true,
    }
  },

  init = function()
    vim.g.no_plugin_maps = true
  end,

  keys = {
    { "am", select("@function.outer", "textobjects"), mode = { "x", "o" }, desc = "Function outer" },
    { "im", select("@function.inner", "textobjects"), mode = { "x", "o" }, desc = "Function inner" },
    { "ac", select("@class.outer", "textobjects"), mode = { "x", "o" }, desc = "Class outer" },
    { "ic", select("@class.inner", "textobjects"), mode = { "x", "o" }, desc = "Class inner" },
    { "as", select("@local.scope", "locals"), mode = { "x", "o" }, desc = "Local scope" },
    {
      "[[",
      move("goto_previous_start", "@function.outer", "textobjects"),
      mode = { "n", "x", "o" },
      desc = "Previous function start",
    },
    {
      "[c",
      move("goto_previous_start", "@class.outer", "textobjects"),
      mode = { "n", "x", "o" },
      desc = "Previous class start",
    },
    {
      "]]",
      move("goto_next_start", "@function.outer", "textobjects"),
      mode = { "n", "x", "o" },
      desc = "Next function start",
    },
    {
      "]c",
      move("goto_next_start", "@class.outer", "textobjects"),
      mode = { "n", "x", "o" },
      desc = "Next class start",
    },
  },

}
