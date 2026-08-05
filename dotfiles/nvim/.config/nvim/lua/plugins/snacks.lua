---@diagnostic disable: undefined-doc-name, undefined-global

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  cond = not vim.g.vscode, -- never load inside VS Code, it doesn't render this

  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          follow_file = false, -- we handle following ourselves, scoped to the workspace
          hidden = true,
          focus = "list",
          actions = {
            explorer_expand_all = function(picker, item)
              local Tree = require("snacks.explorer.tree")
              local Actions = require("snacks.explorer.actions")
              local node = item and Tree:node(item.file) or Tree:node(picker:cwd())
              if not node then return end

              local function expand(n)
                if n.dir and not n.open then
                  Tree:toggle(n.path)
                end
                vim.schedule(function()
                  Actions.update(picker, { refresh = true })
                  for _, child in pairs(n.children or {}) do
                    if child.dir then
                      expand(child)
                    end
                  end
                end)
              end
              expand(node)
            end,

            explorer_collapse_all = function(picker, item)
              local Tree = require("snacks.explorer.tree")
              local Actions = require("snacks.explorer.actions")
              local node = item and Tree:node(item.file) or Tree:node(picker:cwd())
              if not node then return end

              local function collapse(n)
                for _, child in pairs(n.children or {}) do
                  if child.dir then
                    collapse(child)
                  end
                end
                if n.dir and n.open then
                  Tree:toggle(n.path)
                end
              end
              collapse(node)
              Actions.update(picker, { refresh = true })
            end,

            explorer_oil_here = function(_, item)
              if not item then return end

              local is_dir = item.dir
              local dir = is_dir and item.file or vim.fn.fnamemodify(item.file, ":h")
              local target_name = not is_dir and vim.fn.fnamemodify(item.file, ":t") or nil

              require("oil").open_float(dir, {}, function()
                if not target_name then return end
                vim.schedule(function()
                  local buf = vim.api.nvim_get_current_buf()
                  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                  for lnum, line in ipairs(lines) do
                    if line:find(target_name, 1, true) then
                      vim.api.nvim_win_set_cursor(0, { lnum, 0 })
                      break
                    end
                  end
                end)
              end)
            end,

            explorer_open_keep_search = function(picker, item)
              if not item or item.dir then
                return -- let folders behave normally (expand/collapse)
              end
              picker:action("jump")
            end,
          },
          win = {
            input = {
              keys = {
                ["q"] = "", -- unbind here too
                ["<Esc>"] = "", -- unbind here too
              }
            },
            list = {
              keys = {
                ["<Esc>"] = "", -- unbind here too
                ["q"] = "", -- unbind here too
                ["E"] = "explorer_expand_all",
                ["W"] = "explorer_collapse_all",
                ["O"] = "explorer_oil_here",
                ["<C-w>h"] = function() vim.cmd.wincmd("h") end,
                ["<C-w>j"] = function() vim.cmd.wincmd("j") end,
                ["<C-w>k"] = function() vim.cmd.wincmd("k") end,
                ["<C-w>l"] = function() vim.cmd.wincmd("l") end,
              },
            },
          },
        },
      },
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = { enabled = true },
  },
  -- kill LazyVim's inherited <leader>e so it can't race with ours
  keys = {
    { "<leader>e", false },
  },
}
