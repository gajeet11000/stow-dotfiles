return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/",
    need = 1,
    branch = true,
  },
  keys = {
    { "<leader>qS", function() require("persistence").select() end,  desc = "Select Session" },
    { "<leader>qd", function() require("persistence").stop() end,    desc = "Don't Save Current Session" },
  },
  init = function()
    local function nuke_snacks_explorer_buffers()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].filetype == "snacks_picker_list" then
          pcall(vim.api.nvim_buf_delete, buf, { force = true })
        end
      end
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistenceSavePre",
      callback = nuke_snacks_explorer_buffers,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistenceLoadPost",
      callback = function() vim.schedule(nuke_snacks_explorer_buffers) end,
    })
  end,
}
