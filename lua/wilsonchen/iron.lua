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
		vim.keymap.set("n", "<leader>rc", function()
			vim.api.nvim_feedkeys("vit", "n", false)
			iron.visual_send()
			vim.cmd("IronFocus")
			vim.api.nvim_feedkeys("i", "n", false)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
		end, { desc = "[R]un [C]ell" })

		vim.keymap.set("v", "<leader>ic", function()
			iron.visual_send()
			vim.cmd("IronFocus")
			vim.api.nvim_feedkeys("i", "n", false)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
		end, { desc = "[I]ron [C]ell" })

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

		-- local function back_to_script()
		-- 	local ll = require("iron.lowlevel")
		-- 	local meta = ll.get("python")
		-- 	if ll.repl_exists(meta) then
		-- 		local window = vim.fn.bufwinid(meta.bufnr)
		-- 		if window ~= -1 then
		-- 			vim.cmd('call feedkeys("\\<Esc>", "n")')
		-- 			vim.cmd('call feedkeys("\\<Esc>", "n")')
		-- 			vim.cmd("wincmd h")
		-- 		end
		-- 	end
		-- end

		vim.keymap.set("n", "<leader>ir", "<cmd>IronRestart<CR>", { desc = "[I]ron [R]estart" })
		vim.keymap.set("n", "<leader>is", "<cmd>IronFocus<CR>", { desc = "[I]ron focu[S]" })
		vim.keymap.set("n", "<leader>ih", function()
			untoggle()
		end, { desc = "[I]ron [H]ide" })

		-- vim.keymap.set("t", "<ESC>", function()
		-- 	back_to_script()
		-- end)
	end,
}
