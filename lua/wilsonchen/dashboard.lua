return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[                                                                       ]],
			[[                                                                     ]],
			[[       ████ ██████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      █████████ ███████████████████ ███   ███████████   ]],
			[[     █████████  ███    █████████████ █████ ██████████████   ]],
			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			[[                                                                       ]],
		}
		dashboard.section.buttons.val = {
			dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("S", "󰁯 Load Last Session", ":SessionManager load_last_session<CR>"),
			dashboard.button("s", " Load Session", ":SessionManager load_session<CR>"),
			dashboard.button("p", " Search Project", ":Telescope projects<CR>"),
			dashboard.button("r", " Recently used files", ":Telescope oldfiles <CR>"),
			dashboard.button(
				"t",
				" Settings",
				":lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config')}) <CR>"
			),
			dashboard.button("q", " Leave Neovim", ":q<CR>"),
		}
		alpha.setup(dashboard.opts)
	end,
}
