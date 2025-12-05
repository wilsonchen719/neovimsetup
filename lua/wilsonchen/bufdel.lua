return {
	"ojroques/nvim-bufdel",
	config = function()

		require("bufdel").setup({
			next = 'tabs',
			quit = true,
		})
		vim.keymap.set(
			"n",
			"<leader>bd",
			function()
				vim.cmd('BufDelOthers')
				print("Other bufferes deleted")
			end,
			{ desc = "[B]uffer [D]elete" })
	end,
}
