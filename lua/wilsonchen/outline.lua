return {
	"hedyhli/outline.nvim",
	config = function()
		-- Example mapping to toggle outline
		vim.keymap.set(
			"n",
			"<leader>l",
			function()
				if _G.isZenMode and not vim.g.neovide then
					vim.cmd("ZenMode")
				end
				if _G.isZenMode and vim.g.neovide then
					vim.cmd("lua vim.g.neovide_padding_left = 0")
					_G.isZenMode = false
				end
				vim.cmd("Outline")
			end,
			-- "<cmd>Outline<CR>",
			{ desc = "Toggle Outline" }
		)
		require("outline").setup({
			width = 25,
			relative_width = true,
			show_numbers = true,
			show_relative_numbers = true,
			-- split_command = "30vsplit",
			symbols = {
				filter = {
					default = { "String", exclude = true },
					python = { "Function", "Class", "Method", "Attribute" },
				},
			},
		})
	end,
}
