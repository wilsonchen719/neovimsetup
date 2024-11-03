return {
	"folke/trouble.nvim",
	opts = {
		preview = {
			type="main",
			scratch = false,
		},
		focus= true,
	}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
		  "<leader>xx",
		  "<cmd>Trouble diagnostics toggle<cr>",
		  desc = "Diagnostics (Trouble)",
		},
		{
		  "<leader>xc",
		  "<cmd>Trouble quickfix toggle<cr>",
		  desc = "Diagnostics (QuickFix)",
		},
		{
		"<leader>gr",
		"<cmd>Trouble lsp_references focus = true<cr>",
		}
	}
}

