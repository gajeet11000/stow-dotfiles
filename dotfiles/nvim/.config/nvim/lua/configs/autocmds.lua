local M = {}

function M.setup()
  local treesitter_group = vim.api.nvim_create_augroup("treesitter", { clear = true })
  local explorer_group = vim.api.nvim_create_augroup("explorer", { clear = true })
  local nvim_start_group = vim.api.nvim_create_augroup("nvim_start", { clear = true })

  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    group = nvim_start_group,
    callback = function()
      -- already set some other way, don't override
      if vim.g.explorer_root then return end

      -- get the aruguments passed when launching nvim
      local arg = vim.fn.argv(0)

      -- when non empty arg and a directory otherwise identify root
      if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
        vim.g.explorer_root = vim.fn.fnamemodify(arg, ":p"):gsub("/$", "")
      else
        vim.g.explorer_root = require("configs.utils").get_root()
      end

    end,
  })

  -- TreeSitter
  vim.api.nvim_create_autocmd("FileType", {
    group = treesitter_group,
    callback = function()
      if not vim.g.vscode then
        -- silently ignore the warnings and start treesitter
        pcall(vim.treesitter.start)

        -- enable treesitter based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })

  -- Prevent explorer from changing when opening non cwd buffers.
  vim.api.nvim_create_autocmd("BufEnter", {
    group = explorer_group,
    callback = function(event)
      -- 1. If no workspace has been pinned, there is nothing to do.
      --------------------------------------------------------------------------
      if vim.g.explorer_root == nil then return end

      -- 2. Ignore special buffers: normal buftype=""
      --------------------------------------------------------------------------
      if vim.bo[event.buf].buftype ~= "" then return end

      -- 3. Get the full path of the current buffer.
      --------------------------------------------------------------------------
      local current_file = vim.api.nvim_buf_get_name(event.buf)

      -- 4. New unnamed buffers have no filename.
      --------------------------------------------------------------------------
      if current_file == "" then return end

      -- 5. Remove a trailing "/" if one exists, then add exactly one "/" back.
      --------------------------------------------------------------------------
      local workspace = vim.g.explorer_root:gsub("/$", "") .. "/"

      -- 6. Check if the current file belongs to the workspace.
      --------------------------------------------------------------------------
      local inside_workspace = vim.startswith(current_file, workspace)
      if not inside_workspace then return end

      -- 7. Check whether the Snacks Explorer is actually open.
      --------------------------------------------------------------------------
      local explorer = Snacks.picker.get({ source = "explorer", })[1]
      if explorer == nil then return end

      -- 8. Reveal the current file inside the explorer.
      -- pcall() prevents an error from crashing the callback.
      --------------------------------------------------------------------------
      pcall(function() Snacks.explorer.reveal({ buf = event.buf, }) end)
    end,
  })

end

return M
