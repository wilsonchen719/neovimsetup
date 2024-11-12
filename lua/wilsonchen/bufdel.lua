return {
	"ojroques/nvim-bufdel",
	config = function()

		require("bufdel").setup({
			next = 'tabs',
			quit = true,
		})
		vim.keymap.set("n", "<leader>bd", function() vim.cmd('BufDelOthers') end,{ desc = "[B]uffer [D]elete" })
		-- vim.keymap.set("n", "<leader>a", function() vim.cmd('wq') end,{ desc = "[B]uffer [D]elete" })
		-- Create autocommand that when leaving neovim, call BufDelOthers
		-- vim.api.nvim_create_autocmd("VimLeave", {
		-- 	callback = function()
		-- 		print("Leaving neovim.")
		-- 		-- Let neovim wait for 3 seconds before deleting other buffers
		-- 		vim.cmd("BufDelOthers")
		-- 	end,
		-- })
	end,
}
