return {
	"j-morano/buffer_manager.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local buffermanager = require("buffer_manager")
		buffermanager.setup({
			short_file_names = true,
			loop_nav = true,
		})

		-- Setting up keymaps
		vim.keymap.set(
			"n",
			"<leader>e",
			function()
				require("buffer_manager.ui").toggle_quick_menu()
			end,
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<C-PageDown>",
			function()
				require("buffer_manager.ui").nav_next()
			end,
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<C-PageUp>",
			function()
				require("buffer_manager.ui").nav_prev()
			end,
			{ noremap = true, silent = true }
		)
	end,
}
