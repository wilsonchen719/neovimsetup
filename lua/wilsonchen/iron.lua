return {
	"Vigemus/iron.nvim",
	config = function()
		local iron = require("iron.core")
		local view = require("iron.view")
		local dap = require("dap")
		iron.setup({
			config = {
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
					-- python = { command = function()
					-- 	local str = vim.fn.input("Command")
					-- 	return {"ipython", "--no-autoindent", str}
					-- end,
					-- format = require("iron.fts.common").bracketed_paste_python
					-- }
					python = {
						command = {"ipython"}
					},
					sh = {
						-- kcanbe a table or a function that returns a table.
						command = { "zsh" },
					},
				},
				-- Setting up how REPL is opened.
				repl_open_cmd = view.split.vertical(80),
			},
			-- Irons doesn't set keymaps by default anymore.
			-- You can set them here or manually add keymaps to the functions in iron.core
			keymaps = {
				-- send_motion = "<leader>ic",
				-- visual_send = "<leader>ic",
				send_file = "<leader>if",
				send_line = "<leader>il",
				send_until_cursor = "<leader>iu",
				send_mark = "<leader>im",
				mark_motion = "<leader>mc",
				mark_visual = "<leader>mv",
				remove_mark = "<leader>md",
				interrupt = "<leader>ip",
				exit = "<leader>ie",
				clear = "<leader>ia",
			},
			-- If the higlihgt is on, you can change how it:
			-- For the available options, check nvim_set_hl"
			higlihgt = {
				italic = true,
			},
			ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
			--Floating Version
		})

		local function send_code_to_repl()
			--Exit visual mode.
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
			local start_line = vim.fn.getpos("v")[2]
			local end_line = vim.fn.getpos(".")[2]
			-- In case the user selects from bottom to top.
			if start_line > end_line then
				start_line, end_line = end_line, start_line
			end
			--
			local lines = {}
			for line_number = start_line, end_line do
				table.insert(lines, vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1])
			end
			-- dap.repl.open()
			dap.repl.execute(table.concat(lines, "\n"))
		end

		vim.keymap.set("n", "<S-CR>", function()
			if vim.g.neovide and _G.isZenMode then
				vim.g.neovide_padding_left = 0
				_G.isZenMode = false
			end
			vim.api.nvim_feedkeys("vit", "n", false)
			iron.visual_send()
			vim.cmd("IronFocus")
			vim.api.nvim_feedkeys("i", "n", false)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
		end, { desc = "[R]un [C]ell" })

		-- If debug mode is on, then Shift + Enter becomes sending code to dap-repl.
		-- If debug mode is off, then Shift + Enter will run iron.

		vim.keymap.set("v", "<S-Cr>", function()
			if _G.isNvimDapRunning then
				send_code_to_repl()
			else
				if vim.g.neovide and _G.isZenMode then
					vim.g.neovide_padding_left = 0
					_G.isZenMode = false
				end

				iron.visual_send()
				vim.cmd("IronFocus")
				vim.api.nvim_feedkeys("i", "n", false)
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
			end
		end, { desc = "Run Visually Selected Code in REPL" })

		local function untoggle()
			local ll = require("iron.lowlevel")
			local meta = ll.get("python")
			if ll.repl_exists(meta) then
				local window = vim.fn.bufwinid(meta.bufnr)
				if window ~= -1 then
					vim.api.nvim_win_hide(window)
				else
					iron.focus_on("python")
					vim.api.nvim_feedkeys("i", "n", false)
				end
			end
		end

		vim.keymap.set("n", "<leader>ir", "<cmd>IronRestart<CR>", { desc = "[I]ron [R]estart" })
		vim.keymap.set("n", "<leader>is", "<cmd>IronFocus<CR>", { desc = "[I]ron focu[S]" })
		vim.keymap.set("n", "<leader>ih", function()
			untoggle()
		end, { desc = "[I]ron [H]ide" })
	end,
}
