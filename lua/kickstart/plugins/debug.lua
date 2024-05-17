-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

-- NOTE: Customized functions to send multilple line to dap-repl
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
			local function is_multiline(text)
				if string.sub(text, -1) == ':' then
					return true
				elseif string.sub(text, -1) == '\\' then
					return true
				elseif select(2, string.gsub(text, '"""', "")) == 1 then
					return true
				end
				return false
			end
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
					is_multiline = is_multiline
				})
			else
				cb({
					type = "executable",
					command = pythonpath,
					args = { "-m", "debugpy.adapter" },
					options = {
						source_filetype = "python",
					},
					is_multiline = is_multiline
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
				command = "C:/Users/wilsonchen/AppData/Local/Microsoft/WindowsApps/wt.exe",
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
				repl_lang = "python",
			},
		}
		dap.defaults.fallback.force_external_terminal = true
		dap.defaults.fallback.external_terminal = {
			command ="C:/Users/wilsonchen/AppData/Local/Microsoft/WindowsApps/wt.exe";
			arg= {};
		}
		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set("n", "<F5>", function()
			if vim.g.neovide and _G.isZenMode then
				vim.g.neovide_padding_left = 0
				_G.isZenMode = false
			end

			dap.continue()
			end, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F3>", goto.next, { desc = "Debug: Jump Breakpoint" })
		vim.keymap.set("n", "<F4>", goto.stopped, { desc = "Debug: Jump To Stopped Line" })
		vim.keymap.set("n", "<S-F5>", function() 
			dap.terminate()
		end, { desc = "Debug: Terminate" })
		-- vim.keymap.set("n", "<F8>", function()
		-- 	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		-- 	end, { desc = "Debug: Set Breakpoint" })
		vim.keymap.set("n", "<leader>de", function() vim.cmd('lua require("dapui").eval()') end, {desc = "[D]ebug [E]valuate"})
		vim.keymap.set("v", "<leader>de", function() vim.cmd('lua require("dapui").eval()') end, {desc = "[D]ebug [E]aluate"})
		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			layouts = {
				{elements = {"scopes","stacks", "breakpoints"}, size = 30, position = "left"}, --  "watches"
				{elements = {"repl"}, size = 0.25, position = "bottom"}
			}
			
		})

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

		-- Reset debugger icons
		local sign = vim.fn.sign_define
		sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
		sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
		sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})
		sign('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

		dap.listeners.after.event_initialized["dapui_config"] = function() 
			dapui.open()
			_G.isNvimDapRunning = true
		end
		dap.listeners.before.event_terminated["dapui_config"] = function () dapui.close() _G.isNvimDapRunning = false end
		dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() _G.isNvimDapRunning = false end

		-- NOTE: Below is a nice solution for sending multiline into dap-repl.

		-- vim.keymap.set("x", "<leader>di", function()
		-- 	local lines = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"))
		-- 	dap.repl.open()
		-- 	dap.repl.execute(table.concat(lines, "\n"))
		-- end)
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
	},
	{
		"Weissle/persistent-breakpoints.nvim",
		config = function()
			require("persistent-breakpoints").setup{load_breakpoints_event = {"BufReadPost"}}
			vim.keymap.set("n", "<F9>", function() 
				vim.cmd( "lua require('persistent-breakpoints.api').toggle_breakpoint() ")
			end,
			{ desc = "debug: toggle breakpoint" })
			vim.keymap.set("n", "<F8>", function() 
				vim.cmd( "lua require('persistent-breakpoints.api').set_conditional_breakpoint() ")
			end,
			{ desc = "debug: toggle breakpoint" })
		end
	}
}
--
-- vim.keymap.set('n', '<leader>ll', function() add_line(vim.fn.getreg('"')) end, {buffer = vim.fn.bufnr("dap-repl")})
