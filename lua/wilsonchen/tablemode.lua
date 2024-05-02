return {
	"dhruvasagar/vim-table-mode",
	opts = {},
	config = function()
		vim.g.table_mode_motion_right_map = "<tab>"
		vim.g.table_mode_motion_left_map = "<S-tab>"
	end,
}

-- NOTE: You can review all tricks and tips of table mode here. https://github.com/dhruvasagar/vim-table-mode
