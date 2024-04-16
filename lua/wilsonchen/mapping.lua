local M = {}

M.dap = {
	plugin = true,
	n = {
		["<leader>db"] = { "<cmd> DaptToggleBreakpoint <CR>" },
	},
}
M.dap_python = {
	plugin = true,
	n = {
		["<leader>dpr"] = {
			function()
				require("dap-python").test_method()
			end,
		},
	},
}
return M
