return {

	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
	},
	config = function()
		local neogit = require("neogit")
		neogit.setup({})
		vim.keymap.set("n", "<leader>gs", function()
			vim.cmd("Neogit kind=vsplit")
		end, { desc = "[G]it [S]tatus" })

		vim.keymap.set("n", "<leader>gf", function()
			vim.cmd("DiffviewOpen")
		end, { desc = "[G]it Dif[f]" })
	end,
}
