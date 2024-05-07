vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		local session_manager = require("session_manager")
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			-- Don't save while there's any 'nofile' buffer open.
			if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "nofile" then
				return
			end
		end
		session_manager.save_current_session()
	end,
})

return {
	"Shatur/neovim-session-manager",
	config = function()
		local Path = require("plenary.path")
		local config = require("session_manager.config")
		require("session_manager").setup({
			sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.ir, - Function that replaces symbols into separators and colons to transform filename into a session directory.
			-- dir_to_session_filename = dir_to_session_filename, -- Function that replaces separators and colons into special symbols to transform session directory into a filename. Should use `vim.loop.cwd()` if the passed `dir` is `nil`.
			autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
			autosave_last_session = true, -- Automatically save last session on exit and on session switch.
			autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
			autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
			autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
				"gitcommit",
				"gitrebase",
			},
			autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
			autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
			max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
		})
	end,
}

-- return {
-- 	"jedrzejboczar/possession.nvim",
-- 	config = function()
-- 		require("possession").setup({
-- 			commands = {
-- 				save = "SSave",
-- 				load = "SLoad",
-- 				delete = "SDelete",
-- 				list = "SList",
-- 			},
-- 			autosave = {
-- 				current = true,
-- 				tmp = true,
-- 				tmp_name = "tmp",
-- 				on_load = true,
-- 				on_quit = true,
-- 			},
-- 			plugins = {
-- 				close_windows = {
-- 					hooks = { "before_save", "before_load" },
-- 					preserve_layout = true, -- or fun(win): boolean
-- 					match = {
-- 						floating = true,
-- 						buftype = {},
-- 						filetype = {},
-- 						custom = false, -- or fun(win): boolean
-- 					},
-- 				},
-- 				-- delete_hidden_buffers = {
-- 				-- 	hooks = {
-- 				-- 		'before_load',
-- 				-- 		vim.o.sessionoptions:match('buffer') and 'before_save',
-- 				-- 	},
-- 				-- 	force = false,  -- or fun(buf): boolean
-- 				-- },
-- 				delete_hidden_buffers = false,
-- 				nvim_tree = true,
-- 				neo_tree = true,
-- 				symbols_outline = true,
-- 				tabby = true,
-- 				dap = true,
-- 				dapui = true,
-- 				neotest = true,
-- 				delete_buffers = false,
-- 			},
-- 		})
-- 	end,
-- }
