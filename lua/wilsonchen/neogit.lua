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
			if vim.g.neovide and _G.isZenMode then
				vim.cmd("lua vim.g.neovide_padding_left = 0")
				_G.isZenMode = false
				vim.cmd("Neogit kind=vsplit")
				vim.cmd("vertical resize 40")
			else
				vim.cmd("Neogit kind=vsplit")
				vim.cmd("vertical resize 80")
			end
		end, { desc = "[G]it [S]tatus" })

		vim.keymap.set("n", "<leader>gf", function()
			if vim.g.neovide and _G.isZenMode then
				vim.cmd("lua vim.g.neovide_padding_left = 0")
				_G.isZenMode = false
			end
			vim.cmd("DiffviewOpen")
		end, { desc = "[G]it Dif[f]" })

		-- vim.keymap.set("n", "gh", function() vim.cmd("diffget //2") end,{Desc=  "Diff Get 2" })
		-- vim.keymap.set("n", "gl", function() vim.cmd("diffget //3") end,{Desc=  "Diff Get 3" })

	end,
}
