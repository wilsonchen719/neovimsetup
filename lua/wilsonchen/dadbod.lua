return {
	"https://github.com/kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "https://github.com/tpope/vim-dadbod", lazy = true },
		{"https://github.com/kristijanhusak/vim-dadbod-completion", ft = {"sql", "mysql", "plsql", "pgsql", "sqlserver", "tssql"}, lazy=true},
		{"https://github.com/tpope/vim-dispatch"},
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function ()
		vim.keymap.set("n", "<leader>db", ":DBUIToggle<CR>")
		vim.api.nvim_del_keymap('n', '<C-j>')
		vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
		vim.api.nvim_del_keymap('n', '<C-k>')
		vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
	end
}
