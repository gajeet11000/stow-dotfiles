---@diagnostic disable: undefined-global
-- lua/plugins/java.lua

return {
	"mason-org/mason.nvim",
	opts = {},
	config = function(_, opts)
		require("mason").setup(opts)
		vim.lsp.config("jdtls", {
			cmd_env = {
				JAVA_HOME = "/usr/lib/jvm/java-21-openjdk",
			},
			root_dir = function(bufnr, on_dir)
				local fname = vim.api.nvim_buf_get_name(bufnr)
				local root = vim.fs.root(fname, { "pom.xml", "build.gradle", ".git" })
				on_dir(root or vim.fs.dirname(fname))
			end,
		})
		vim.lsp.enable("jdtls")
	end,
}
