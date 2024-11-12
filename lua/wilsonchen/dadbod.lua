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
		vim.keymap.set("n", "<leader>db", function() vim.cmd('tabnew') vim.cmd( 'DBUIToggle' )end)
	end
}
