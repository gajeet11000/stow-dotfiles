local utils = require("configs.utils")

return {
  follow_file = false,
  hidden = true,
  focus = "list",

actions = {
    explorer_expand_all = utils.explorer_expand_all,
    explorer_collapse_all = utils.explorer_collapse_all,
    explorer_oil_here = utils.explorer_oil_here,
},

  win = {
    input = {
      keys = {
        ["q"] = "",
        ["<Esc>"] = "",
      },
    },

    list = {
      keys = {
        ["q"] = "",
        ["<Esc>"] = "",

        ["E"] = "explorer_expand_all",
        ["W"] = "explorer_collapse_all",
        ["O"] = "explorer_oil_here",
      },
    },
  },
}
