return {
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", function()
				if _G.isZenMode then
					vim.cmd("ZenMode")
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
