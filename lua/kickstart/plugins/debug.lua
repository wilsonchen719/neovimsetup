-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
	-- NOTE: Yes, you can install new plugins here!
	"mfussenegger/nvim-dap",
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	config = function(_, opts)
		local dapui = require("dapui")
		--local path = "C:\\Users\\wilsonchen\\AppData\\Local\\anaconda3"
		require("mason-nvim-dap").setup(opts)
		local dap = require("dap")
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
					command = "C:\\Users\\wilsonchen\\AppData\\Local\\anaconda3\\pythonw.exe",
					args = { "-m", "debugpy.adapters" },
					options = {
						source_filetype = "python",
					},
				})
			end
		end
		dap.configurations.python = {
			{
				-- The first three options are required by nvim-dap
				type = "python", -- the type established the link to the adapter definition:
				request = "launch",
				name = "Launch File",
				-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
				program = "${file}", -- This configuration will lauch the current file if used
				pythonPath = function()
					--debubpy supports lauching an application with a different intepereter then  the one used lauch debugpy itself.
					--The code below looks for a `venv` or `.venv` folder in the current direclty and uses Python within.
					-- You can adapt this - to for example use the `VIRTUAL_ENV` environment variable.
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/Scripts/pythonw.exe") == 1 then
						return cwd .. "/venv/Scripts/pythonw.exe"
					elseif vim.fn.executable(cwd .. "/.venv/Scripts/pythonw.exe") == 1 then
						return cwd .. "/.venv/Scripts/pythonw.exe"
					else
						return "C:\\Users\\wilsonchen\\AppData\\Local\\anaconda3\\pythonw.exe"
					end
				end,
			},
		}

		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set("n", "<F5>", function()
			dap.continue()
		end, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Install golang specific config
		--require("dap-go").setup()
		--require("dap-python").setup(path)
	end,
}
