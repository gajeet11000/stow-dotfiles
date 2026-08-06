-- Manually (re)pin the workspace, like "Open Folder" in VS Code
vim.api.nvim_create_user_command("PinRoot", function(opts)

  if opts.args == "" then
    vim.g.explorer_root = vim.fn.expand("%:p:h")
  else
    vim.g.explorer_root = vim.fn.fnamemodify(opts.args, ":p:h")
  end

  Snacks.explorer({ cwd = vim.g.explorer_root })

  vim.notify("Workspace pinned: " .. vim.g.explorer_root)

end, { nargs = "?", complete = "dir" })
