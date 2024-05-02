return {
	"dhruvasagar/vim-table-mode",
	opts = {},
	config = function()
		vim.g.table_mode_motion_right_map = "<tab>"
		vim.g.table_mode_motion_left_map = "<S-tab>"
	end,
}

-- TODO: Make shortcut to jump to next columns with tab....
-- NOTE: You can review all tricks and tips of table mode here. https://github.com/dhruvasagar/vim-table-mode
