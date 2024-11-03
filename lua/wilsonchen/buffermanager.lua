return{
	"j-morano/buffer_manager.nvim",
	config = function()
		vim.keymap.set("n", "<leader>sb", function()
		require("buffer_manager.ui").toggle_quick_menu()
		end, { desc = "buffer manager" })
	end

}
