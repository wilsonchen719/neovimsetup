return {
	"ahmedkhalf/project.nvim",
	dependencies = { "nvim-tree/nvim-tree.lua" },
	config = function()
		require("telescope").load_extension("projects")
		require("nvim-tree").setup({
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
		})
		require("project_nvim").setup({})
	end,
}
