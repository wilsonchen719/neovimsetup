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
				send_motion = "<leader>ic",
				visual_send = "<leader>ic",
				send_file = "<leader>if",
				send_line = "<leader>il",
				send_until_cursor = "<leader>iu",
				send_mark = "<leader>im",
				mark_motion = "<leader>mc",
				mark_visual = "<leaderd>mc",
				remove_mark = "<leader>md",
				cr = "<S-CR>",
				interrupt = "<space>is",
				exit = "<spaced>ie",
				clear = "<space>ir",
			},
			-- If the higlihgt is on, you can change how it
			-- For the available options, check nvim_set_hl
			higlihgt = {
				italic = true,
			},
			ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
			--Floating Version
		})
	end,
}
