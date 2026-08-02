---@diagnostic disable: undefined-global

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup()

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					if not vim.g.vscode then
						pcall(vim.treesitter.start) -- skip in VS Code, it already highlights
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			local ensure_installed = { "lua", "python", "javascript", "typescript", "tsx", "java", "json", "html", "css" }
			local installed = require("nvim-treesitter.config").get_installed()
			local to_install = vim.iter(ensure_installed)
				:filter(function(p) return not vim.tbl_contains(installed, p) end)
				:totable()
			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end
		end,
	},
	{
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

			local select = require("nvim-treesitter-textobjects.select")
			vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end)
			vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end)
			vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end)
			vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end)
		end,
	},
}
