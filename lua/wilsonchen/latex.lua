return {
	"jbyuki/nabla.nvim",
	config = function()
		vim.keymap.set("n", "<leader>pp", "<cmd>lua require('nabla').popup()<CR>")
	end,
}
