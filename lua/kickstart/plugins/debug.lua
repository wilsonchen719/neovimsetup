-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return { {
	-- NOTE: Yes, you can install new plugins here!
	"mfussenegger/nvim-dap",
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",
		-- Plugins for better debuggin experience like jumping btw breakpoints
		"ofirgall/goto-breakpoints.nvim",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	config = function(_, opts)
		require("mason-nvim-dap").setup(opts)
		local dap = require("dap")
		local dapui = require("dapui")
		local goto = require("goto-breakpoints")
		-- local pythonpath = vim.fn.exepath("python")
		local pythonpath = "C:\\Users\\wilsonchen\\AppData\\Local\\anaconda3\\envs\\debugpy\\python.exe"
		--{
		-- -- Makes a best effort to setup the various debuggers with
		-- -- reasonable debug configurations
		-- --
		-- automatic_installation = true,
		-- automatic_setup = true,
		--
		-- -- You can provide additional configuration to the handlers,
		-- -- see mason-nvim-dap README for more information
		-- handlers = {},
		--
		-- -- You'll need to check that you have the required things installed
		-- -- online, please don't ask me how to install them :
		-- ensure_installed = {
		-- 	-- Update this to ensure that you have the debuggers for the langs you want
		-- 	"delve",
		-- 	"debugpy",
		-- },
		--})
		dap.adapters.python = function(cb, config)
			if config.request == "attach" then
				---@diagnostic disable-next-line: undefined-field
				local port = (config.connect or config).port
				---@diagnostic disable-next-line: undefined-field
				local host = (config.connect or config).host or "127.0.0.1"
				cb({
					type = "server",
					port = assert(port, "`connect.port` is required for a python `attach` configuration"),
					host = host,
					options = {
						source_filetype = "python",
					},
				})
			else
				cb({
					type = "executable",
					command = pythonpath,
					args = { "-m", "debugpy.adapter" },
					options = {
						source_filetype = "python",
					},
				})
			end
		end
		dap.configurations.python = {
			{
				-- The first three options are required by nvim-dap
				type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
				request = "launch",
				name = "Launch file in externalTerminal",

				-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
				program = "${file}", -- This configuration will launch the current file if used.
				console = "externalTerminal",
				pythonPath = function()
					-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
					-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
					-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/Scripts/pythonw.exe") == 1 then
						return pythonpath
					elseif vim.fn.executable(cwd .. "/.venv/Scripts/pythonw.exe") == 1 then
						return pythonpath
					else
						-- Please modify your code here to auto-select initial program
						local current_env_python = os.getenv('CONDA_DEFAULT_ENV')
						return "C:\\Users\\wilsonchen\\AppData\\Local\\anaconda3\\envs\\" .. current_env_python .. "\\python.exe"
					end
				end,
			},
		}
		dap.defaults.fallback.force_external_terminal = true
		dap.defaults.fallback.external_terminal = {
			command ="C:/Users/wilsonchen/AppData/Local/Microsoft/WindowsApps/wt.exe";
			arg= {};
		}

		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set("n", "<F5>", function()
			dap.continue()
			end, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F3>", goto.next, { desc = "Debug: Jump Breakpoint" })
		vim.keymap.set("n", "<F4>", goto.stopped, { desc = "Debug: Jump To Stopped Line" })
		vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<F8>", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Breakpoint" })

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
		})

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

		-- Reset debugger icons
		local sign = vim.fn.sign_define
		sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
		sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
		sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})
		sign('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Install golang specific config
		--require("dap-go").setup()
		--require("dap-python").setup(path)
	end, },
	{
		"wilsonchen719/visidata.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui"
		},
		config = function()
			vim.keymap.set("v", "<leader>vp",
				function()require("visidata").visualize_pandas_df()end, { desc = "[V]isualize [P]andas" })
		end,		
	},
	{
		"rcarriga/cmp-dap",
		config = function()
			require("cmp").setup({
				  enabled = function()
					return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
						or require("cmp_dap").is_dap_buffer()
				  end
				})
			require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
			  sources = {
				{ name = "dap" },
				{ name = "luasnip"},
			  },
			})
		end
	}
}
