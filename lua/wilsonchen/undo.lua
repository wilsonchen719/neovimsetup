return {
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", function()
				if _G.isZenMode and not vim.g.neovide then
					vim.cmd("ZenMode")
				end
				if _G.isZenMode and vim.g.neovide then
					vim.cmd("lua vim.g.neovide_padding_left = 0")
					_G.isZenMode = false
				end

				vim.cmd.UndotreeToggle()
			end, { desc = "Toggle [U]ndotree" })
		end,
	},
	-- {
	-- 	"tzachar/highlight-undo.nvim",
	-- 	config = function()
	-- 		require("highlight-undo").setup({
	-- 			-- The duration of highlight.
	-- 			duration = 300,
	-- 			undo = {
	-- 				hlgroup = "HighlightUndo",
	-- 				mode = "n",
	-- 				lhs = "u",
	-- 				map = "undo",
	-- 				opts = {},
	-- 			},
	-- 			redo = {
	-- 				hlgroup = "HighlightRedo",
	-- 				mode = "n",
	-- 				lhs = "<C-r>",
	-- 				map = "redo",
	-- 				opts = {},
	-- 			},
	-- 			highlight_for_count = true,
	-- 		})
	-- 	end,
	-- },
}
