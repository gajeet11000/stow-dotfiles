return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()
    require("configs.treesitter").install_parsers({
      "lua",
      "python",
      "javascript",
      "typescript",
      "tsx",
      "java",
      "json",
      "html",
      "css",
    })
  end
}
