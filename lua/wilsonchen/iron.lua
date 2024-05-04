return {
	"Vigemus/iron.nvim",
	config = function()
		local iron = require("iron.core")
		local view = require("iron.view")
		iron.setup({
			config = {
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
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
				mark_visual = "<leaderd>mc",
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
		local function intToLetter(n)
			local alphabet = "abcdefghijklmnopqrstuvwxyz"
			local upperAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
			if n >= 1 and n <= 26 then
				return alphabet:sub(n, n)
			elseif n >= 27 and n <= 52 then
				return upperAlphabet:sub(n - 26, n - 26)
			else
				print("Can't do more than 52 lines.")
			end
		end

		local function copy_paste_code_to_repl_line_by_line()
			local start_line = vim.fn.getpos("'<")[2]
			local end_line = vim.fn.getpos("'>")[2]
			local buffer = vim.api.nvim_get_current_buf()
			-- print(start_line)
			-- print(end_line)
			-- print(end_line - start_line)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", false)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w><C-j>", true, true, true), "n", false)
			vim.api.nvim_feedkeys("i", "n", false)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-CR>", true, true, true), "", false)

			for line_number = start_line, end_line do
				local line_content = vim.api.nvim_buf_get_lines(buffer, line_number - 1, line_number, false)[1]
				local register_str = intToLetter(line_number - start_line + 1)
				vim.api.nvim_call_function("setreg", { register_str, line_content })
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes("<C-R>" .. register_str, true, true, true),
					"n",
					true
				)
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "", false)
			end
		end

		vim.keymap.set("n", "<S-CR>", function()
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
				copy_paste_code_to_repl_line_by_line()
			else
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
