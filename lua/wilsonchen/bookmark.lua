return {
	"crusj/bookmarks.nvim",
	branch = "main",
	dependencies = { "nvim-web-devicons" },
	config = function()
		local bookmarks = require("bookmarks")
		bookmarks.setup({
			mappings_enabled = false,
			keymap = {},
		})
		require("telescope").load_extension("bookmarks")
		vim.keymap.set("n", "<leader>ba", function()
			bookmarks.add_bookmarks(false)
		end, { desc = "[B]ookmark [A]dd" })
		vim.keymap.set("n", "<leader>bd", function()
			require("bookmarks.list").delete_on_virt()
		end, { desc = "[B]ookmark [D]elete" })
		vim.keymap.set("n", "<leader>bs", function()
			require("bookmarks.list").show_desc()
		end, { desc = "[B]ookmark [S]how" })
		vim.keymap.set("n", "<leader>sm", function()
			vim.cmd("Telescope bookmarks")
		end, { desc = "[S]earch [B]ookmarks" })
		vim.keymap.set("n", "<leader>bt", function()
			bookmarks.toggle_bookmarks()
		end, { desc = "[B]ookmarks [T]oggle" })
	end,
}
