return {
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},
	{
		"tzachar/highlight-undo.nvim",
		opts = {},
		-- config = function()
		-- 	require("highlight-undo").setup({
		-- 		-- The duration of highlight.
		-- 		duration = 300,
		-- 		undo = {
		-- 			hlgroup = "HighlightUndo",
		-- 			mode = "n",
		-- 			lhs = "u",
		-- 			map = "undo",
		-- 			opts = {},
		-- 		},
		-- 		redo = {
		-- 			hlgroup = "HighlightRedo",
		-- 			mode = "n",
		-- 			lhs = "<C-r>",
		-- 			map = "redo",
		-- 			opts = {},
		-- 		},
		-- 		highlight_for_count = true,
		-- 	})
		-- end,
	},
}
