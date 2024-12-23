_G.isZenMode = false
_G.isNvimDapRunning = false
_G.zenModeWidth = 450
vim.g.mapleader = " "
vim.g.have_nerd_font = true
vim.g.conform_black_options = "--line-length 120"

if vim.g.neovide then
	local alpha = function()
		return string.format("%x", math.floor((255 * vim.g.transparency) or 0.9))
	end
	vim.o.guifont = "FiraCode Nerd Font:h12"
	-- vim.o.guifont = "JetBrainsMonoNL Nerd Font:h12"
	vim.g.neovide_transparency = 0.8
	vim.g.transparency = 0.5
	vim.g.neovide_background_color = "#0f1117" .. alpha()
	vim.g.neovide_window_blurred = true
	vim.g.neovide_floating_blurred = true
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	-- vim.g.neovide_padding_left = 300
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 10
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5
	vim.g.neovide_show_border = true
	vim.api.nvim_set_keymap("i", "<c-v>", "<c-r>+", { noremap = true })
	vim.api.nvim_set_keymap("c", "<c-v>", "<c-r>+", { noremap = true })
else
  vim.opt.guicursor = "n-v-i-c:block-Cursor"
end


-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
-- Custom Tab behavior
vim.opt.tabstop = 4 -- A TAB character looks like 4 spaces
vim.opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = 4 -- Number of spaces inserted when indenting-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "120"
vim.opt.textwidth = 0
vim.opt.wrap = false
vim.opt.conceallevel = 2
vim.o.swapfile = false


-- Fat Cursor

-- Stop autoindenting next line.
vim.opt.formatoptions = "cro" -- Auto-wrap comments using textwidth
-- vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"
vim.opt.shell = "C:/Users/wilsonchen/AppData/Local/Microsoft/WindowsApps/Microsoft.PowerShell_8wekyb3d8bbwe/pwsh.exe"
vim.opt.shell = "pwsh"
vim.opt.shellcmdflag = "-nologo -noprofile -ExecutionPolicy RemoteSigned -command"
vim.opt.shellxquote = ""


-- vim.opt.shell = "C:/Users/wilsonchen/AppData/Local/Programs/nu/bin/nu.exe"
-- vim.o.shellcmdflag = '-c'
-- vim.o.shellquote = ''
-- vim.o.shellxquote = ''

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`

vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Confined auto-complete suggestions to 20 results
vim.opt.pumheight = 20
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

--Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "│ ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "\\d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "Q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keymaps to jump between buffers.
-- vim.keymap.set("n", "<C-PageUp>", function()
-- 	vim.cmd("bprevious")
-- end, { desc = "Go to previous buffer" })
--
-- vim.keymap.set("n", "<C-PageDown>", function()
-- 	vim.cmd("bnext")
-- end, { desc = "Go to next buffer" })

vim.keymap.set("n", "<leader>a", function()
	vim.cmd("w")
  local old_buf = vim.api.nvim_get_current_buf()
  vim.cmd("bnext")
  vim.cmd('bdelete ' .. old_buf)
end, { desc = "" })


-- Keymaps

if vim.g.neovide then
	vim.keymap.set("n", "<C-z>", function()
		if _G.isZenMode then
			vim.cmd("lua vim.g.neovide_padding_left = 0")
			_G.isZenMode = false
		else
			vim.cmd(string.format("lua vim.g.neovide_padding_left = %d", _G.zenModeWidth))
			_G.isZenMode = true
		end
	end)
else
	vim.keymap.set("n", "<C-z>", "<cmd>ZenMode<CR>")
end
-- vim.keymap.set("n", "<C-z>", "<cmd>ZenMode<CR>")

-- Easiest Way to Escape Insert Mode.
-- Use jk to escape insert mode
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true })

-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.

--File Navigation Modification, center
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "p", '"_dP') -- Paste without yanking

--Quick Safe
vim.keymap.set("n", "<leader>q", function()
	local save_and_quite = function()
		vim.cmd("wq")
	end
	local status, _ = pcall(save_and_quite)
	if not status then
		vim.cmd("q")
	end
end, { desc = "Save and Quit" })

vim.keymap.set("n", "q", function()
	local save_and_quite = function()
		vim.cmd("q")
	end
	local status, _ = pcall(save_and_quite)
	if not status then
		print("Must save before quiting")
	end
end, { desc = "Quit" })
-- Remap the keymap for recording macros
vim.api.nvim_set_keymap("n", "<leader>rr", "q", { noremap = true })
-- vim.keymap.set("n", ">", ">>", { desc = "Indent line" })
-- vim.keymap.set("n", "<", "<<", { desc = "Indent line" })

--local Path = require("plenary.path")
--local current_directory = Path:new("."):absolute()
--print(current_directory)
-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Oil Remap
vim.keymap.set("n", "<leader>o", function()
	-- If we are in Neovide and in my defined zen mode. (Then turn off padding.)
	if _G.isZenMode and vim.g.neovide then
		vim.cmd("lua vim.g.neovide_padding_left = 0")
		_G.isZenMode = false
		vim.cmd("vsplit | wincmd l | vertical resize 40")
		require("oil").open()
	else
		vim.cmd("vsplit | wincmd l | vertical resize 80")
		require("oil").open()
	end
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>pv", function()
	require("oil").open()
end, { noremap = true, silent = true })
vim.keymap.set("n", "+", "<cmd>30winc ><CR>", { noremap = true, silent = true })
vim.keymap.set("n", "-", "<cmd>30winc <<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>-", "<cmd>10winc -<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>+", "<cmd>10winc +<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>_", "<cmd>vertical resize |<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>|", "<cmd>horizontal resize _<CR>", { noremap = true, silent = true })
-- [[ Basic Autocommands ]
--  See `:help lua-guide-`

-- Highlight when yanking (copying)
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Create autocmd to set keymaps for oil://* buffers

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({

	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"jiangmiao/auto-pairs",
	"BurntSushi/ripgrep",
	-- {
	-- 	"wilsonchen719/centerpad.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.keymap.set(
	-- 			"n",
	-- 			"<C-z>",
	-- 			"<cmd>lua require('centerpad').toggle{ leftpad = 30, rightpad = 20 }<cr>",
	-- 			{ silent = true, noremap = true, desc = "Center Editor" }
	-- 		)
	-- 		vim.keymap.set("n", "<leader>q", function()
	-- 			if vim.fn.bufexists("leftpad") then
	-- 				vim.cmd("bw leftpad")
	-- 				vim.cmd("bw rightpad")
	-- 				vim.cmd("wq")
	-- 			else
	-- 				vim.cmd("wq")
	-- 			end
	-- 		end)
	-- 		-- if next(vim.fn.argv()) ~= nil then
	-- 		vim.cmd("Centerpad 25 20")
	-- 		-- end
	-- 	end,
	-- },
	{
		"folke/zen-mode.nvim",
		event = "VimEnter",
		opts = {
			window = {
				backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
				-- height and width can be:
				-- * an absolute number of cells when > 1
				-- * a percentage of the width / height of the editor when <= 1
				-- * a function that returns the width or the height
				width = 120, -- width of the Zen window
				height = 1, -- height of the Zen window
				-- by default, no options are changed for the Zen window
				-- uncomment any of the options below, or add other vim.wo options you want to apply
				options = {
					-- signcolumn = "no", -- disable signcolumn
					-- number = false, -- disable number column
					-- relativenumber = false, -- disable relative numbers
					-- cursorline = false, -- disable cursorline
					-- cursorcolumn = false, -- disable cursor column
					-- foldcolumn = "0", -- disable fold column
					-- list = false, -- disable whitespace characters
				},
			},
			plugins = {
				-- disable some global vim options (vim.o...)
				-- comment the lines to not apply the options
				options = {
					enabled = true,
					ruler = false, -- disables the ruler text in the cmd line area
					showcmd = false, -- disables the command in the last line of the screen
					-- you may turn on/off statusline in zen mode by setting 'laststatus'
					-- statusline will be shown only if 'laststatus' == 3
					laststatus = 3, -- turn off the statusline in zen mode
				},
				twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
				gitsigns = { enabled = false }, -- disables git signs
				tmux = { enabled = false }, -- disables the tmux statusline
				-- this will change the font size on kitty when in zen mode
				-- to make this work, you need to set the following kitty options:
				-- - allow_remote_control socket-only
				-- - listen_on unix:/tmp/kitty
				kitty = {
					enabled = false,
					font = "+4", -- font size increment
				},
				-- this will change the font size on alacritty when in zen mode
        -- asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdffasdfasdfasdfas
				-- requires  Alacritty Version 0.10.0 or higher
				-- uses `alacritty msg` subcommand to change font size
				alacritty = {
					enabled = false,
					font = "14", -- font size
				},
				-- this will change the font size on wezterm when in zen mode
				-- See alse also the Plugins/Wezterm section in this projects README
				wezterm = {
					enabled = false,
					-- can be either an absolute font size or the number of incremental steps
					font = "+4", -- (10% increase per step)
				},
			},
			-- callback where you can add custom code when the Zen window opens
			on_open = function(win)
				_G.isZenMode = true
			end,
			-- callback where you can add custom code when the Zen window closes
			on_close = function()
				_G.isZenMode = false
			end,
		},
	},
	"sharkdp/fd",
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					long_message_to_split = true,
					inc_rename = true,
					lsp_doc_border = true,
				},
			})
			require("notify").setup({
				background_colour = "#000000",
        max_width = 30,
        max_height = 20,
				-- on_open = function(win)
				-- 	vim.api.nvim_win_set_config(win, { focusable = false })
				-- end,
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		--@type FlashConfig
		opts = {},
		keys = {
			{
				"s",
				mode = { "n" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			-- {
			-- 	"c-r",
			-- 	mode = { "o", "x" },
			-- 	function()
			-- 		require("flash").treesitter_search()
			-- 	end,
			-- 	desc = "Treesitter Search",
			-- },
			-- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},
	-- NOTE: Plugins can also be added by using a table,
	-- with the first argument being the link and the following
	-- keys can be used to configure plugin behavior/loading/etc.
	--
	-- Use `opts = {}` to force a plugin to be loaded.
	--
	--  This is equivalent to:
	--    require('Comment').setup({})

	-- "gc" to comment visual regions/lines
	-- {
	-- 	"numToStr/Comment.nvim",
	-- 	opts = {},
	-- },

	-- Here is a more advanced example where we pass configuration
	-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
	--    require('gitsigns').setup({ ... })
	--
	-- See `:help gitsigns` to understand what the configuration keys do
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
	--
	-- This is often very useful to both group configuration, as well as handle
	-- lazy loading plugins that don't need to be loaded immediately at startup.
	--
	-- For example, in the following configuration, we use:
	--  event = 'VimEnter'
	--
	-- which loads which-key before all the UI elements are loaded. Events can be
	-- normal autocommands events (`:help autocmd-events`).
	--
	-- Then, because we use the `config` key, the configuration only runs
	-- after the plugin has been loaded:
	--  config = function() ... end

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			})
		end,
	},

	-- NOTE: Plugins can specify dependencies.
	--
	-- The dependencies are proper plugin specificeations as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies of a particular plugin
	--
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`

			require("telescope").setup({
				-- You can put your default mappings / updates / etccopeFuzzyCommandSearch) in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				defaults = {
					-- mappings = {
					--   i = { ['<c-enter>'] = 'to_fuzzy_refine' },
					-- },
					layout_config = {
						vertical = { width = 0.6 },
						horizontal = { height = 0.5 },
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
          file_ignore_patterns = {
            "%.git/",         -- Git directory
            "%.jpg",          -- JPEG images
            "%.jpeg",         -- JPEG images
            "%.png",          -- PNG images
            "%.bmp",          -- Bitmap images
            "%.gif",          -- GIF images
            "%.svg",          -- SVG images
            "%.ico",          -- Icon files
            "%.zip",          -- ZIP archives
            "%.tar",          -- TAR archives
            "%.tar.gz",       -- TAR.GZ archives
            "%.rar",          -- RAR archives
            "%.exe",          -- Executable files
            "%.dll",          -- DLL files
            "%.bin",          -- Binary files
            "%.obj",          -- Object files
            "%.o",            -- Object files
            "%.so",           -- Shared object files
            "%.dylib",        -- Dynamic library files
            "%.class",        -- Java class files
            "%.jar",          -- Java JAR files
            "%.pyc",          -- Python compiled files
            "%.pyo",          -- Python optimized files
            "%.DS_Store",     -- macOS system files
            "thumbs.db"       -- Windows thumbnail cache
          }
        },
				-- pickers = {
				-- 	{
				-- 		layout_config = {
				-- 			prompt_position = "top",
				-- 		},
				-- 		sorting_strategy = "ascending",
				-- 	},
				-- },
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", function()
				builtin.find_files()
			end, { desc = "[S]earch [F]iles" })
			--vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			-- vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      -- I will user buffer manager to manage my buffer going forward.
      --
			-- vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch by [B]uffers" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", function()
				builtin.oldfiles()
				-- require("harpoon"):list():add()
			end, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "[S]earch [S]ymbols" })
			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })
			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
			vim.keymap.set("n", "<leader>su", function()
				builtin.find_files({ cwd = vim.fn.stdpath("data") })
			end, { desc = "[S]earch Neovim pl[u]gins" })
			vim.keymap.set("n", "<leader>sp", function()
				vim.cmd("Telescope projects")
			end, { desc = "[S]earch [P]rojects" })
			-- Although not related to telescope, but I put the session manager search here.
			vim.keymap.set("n", "<leader>sw", function()
				vim.cmd("SessionManager save_current_session")
				vim.cmd("SessionManager load_session")
			end, { desc = "[S]earch [W]orkspace" })
		end,
	},
	{
		"jvgrootveld/telescope-zoxide",
		config = function()
			local t = require("telescope")
			-- local z_utils = require("telescope._extensions.zoxide.utils")
			t.setup({
				extensions = {
					zoxide = {
						prompt_title = "[ Oil Up! ]",
						mappings = {
							default = {
								after_action = function(selection)
									-- print(selection.path)
									vim.cmd("Oil " .. selection.path)
									vim.api.nvim_feedkeys("_", "", false)
								end,
							},
						},
					},
				},
			})
			t.load_extension("zoxide")
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				pattern = { "oil://*" },
				callback = function()
					vim.keymap.set("n", "<C-z>", t.extensions.zoxide.list, { desc = "Jump!", buffer = 0 })
				end,
			})
		end,
	},
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
				-- Set to false if you still want to use netrw.
				default_file_explorer = true,
				-- Id is automatically added at the beginning, and name at the end
				-- See :help oil-columns
				columns = {
					"icon",
					-- "permissions",
					-- "size",
					-- "mtime",
				},
				-- Buffer-local options to use for oil buffers
				buf_options = {
					buflisted = false,
					bufhidden = "hide",
				},
				-- Window-local options to use for oil buffers
				win_options = {
					wrap = false,
					signcolumn = "no",
					cursorcolumn = false,
					foldcolumn = "0",
					spell = false,
					list = false,
					conceallevel = 3,
					concealcursor = "nvic",
				},
				-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
				delete_to_trash = true,
				-- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
				skip_confirm_for_simple_edits = false,
				-- Selecting a new/moved/renamed file or directory will prompt you to save changes first
				-- (:help prompt_save_on_select_new_entry)
				prompt_save_on_select_new_entry = true,
				-- Oil will automatically delete hidden buffers after this delay
				-- You can set the delay to false to disable cleanup entirely
				-- Note that the cleanup process only starts when none of the oil buffers are currently displayed
				cleanup_delay_ms = 2000,
				lsp_file_methods = {
					-- Time to wait for LSP file operations to complete before skipping
					timeout_ms = 1000,
					-- Set to true to autosave buffers that are updated with LSP willRenameFiles
					-- Set to "unmodified" to only save unmodified buffers
					autosave_changes = false,
				},
				-- Constrain the cursor to the editable parts of the oil buffer
				-- Set to `false` to disable, or "name" to keep it on the file names
				constrain_cursor = "editable",
				-- Set to true to watch the filesystem for changes and reload oil
				experimental_watch_for_changes = false,
				-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
				-- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
				-- Additionally, if it is a string that matches "actions.<name>",
				-- it will use the mapping at require("oil.actions").<name>
				-- Set to `false` to remove a keymap
				-- See :help oil-actions for a list of all available actions
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-w>v"] = "actions.select_vsplit", -- No need to set this, it's already set by default.
					["<C-h>"] = "<C-w><C-h>", --Make the behaviour like other normal buffer.
					["<C-l>"] = "<C-w><C-l>", --Make the behaviour like other normal buffer.
					["<C-w>s"] = "actions.select_split",
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-f>"] = "actions.refresh",
					["-"] = "<cmd>30winc <<CR>",
					["^"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["|"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
					["g\\"] = "actions.toggle_trash",
				},
				-- Configuration for the floating keymaps help window
				keymaps_help = {
					border = "rounded",
				},
				-- Set to false to disable all of the above keymaps
				use_default_keymaps = true,
				view_options = {
					-- Show files and directories that start with "."
					show_hidden = false,
					-- This function defines what is considered a "hidden" file
					is_hidden_file = function(name, bufnr)
						return vim.startswith(name, ".")
					end,
					-- This function defines what will never be shown, even when `show_hidden` is set
					is_always_hidden = function(name, bufnr)
						return false
					end,
					-- Sort file names in a more intuitive order for humans. Is less performant,
					-- so you may want to set to false if you work with large directories.
					natural_order = true,
					sort = {
						-- sort order can be "asc" or "desc"
						-- see :help oil-columns to see which columns are sortable
						{ "type", "asc" },
						{ "name", "asc" },
					},
				},
				-- Configuration for the floating window in oil.open_float
				float = {
					-- Padding around the floating window
					padding = 2,
					max_width = 100,
					max_height = 100,
					border = "rounded",
					win_options = {
						winblend = 0,
					},
					-- This is the config that will be passed to nvim_open_win.
					-- Change values here to customize the layout
					override = function(conf)
						return conf
					end,
				},
				-- Configuration for the actions floating preview window
				preview = {
					-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
					-- min_width and max_width can be a single value or a list of mixed integer/float types.
					-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
					max_width = 0.9,
					-- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
					min_width = { 40, 0.4 },
					-- optionally define an integer/float for the exact width of the preview window
					width = nil,
					-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
					-- min_height and max_height can be a single value or a list of mixed integer/float types.
					-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
					max_height = 0.9,
					-- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
					min_height = { 5, 0.1 },
					-- optionally define an integer/float for the exact height of the preview window
					height = nil,
					border = "rounded",
					win_options = {
						winblend = 0,
					},
					-- Whether the preview window is automatically updated when the cursor is moved
					update_on_cursor_moved = true,
				},
				-- Configuration for the floating progress window
				progress = {
					max_width = 0.9,
					min_width = { 40, 0.4 },
					width = nil,
					max_height = { 10, 0.9 },
					min_height = { 5, 0.1 },
					height = nil,
					border = "rounded",
					minimized_border = "none",
					win_options = {
						winblend = 0,
					},
				},
				-- Configuration for the floating SSH window
				ssh = {
					border = "rounded",
				},
			})
		end,
	},
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
      {"williamboman/mason.nvim", config = true},
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{ "folke/neodev.nvim", opts = {} },
      { "hrsh7th/cmp-nvim-lsp" }
		},
		config = function()
			-- Brief aside: **What is LSP?**
			--
			-- LSP is an initialism you've probably heard, but might not understand what it is.
			--
			-- LSP stands for Language Server Protocol. It's a protocol that helps editors
			-- and language tooling communicate in a standardized fashion.
			--
			-- In general, you have a "server" which is some tool built to understand a particular
			-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
			-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
			-- processes that communicate with some "client" - in this case, Neovim!
			--
			-- LSP provides Neovim with features like:
			--  - Go to definition
			--  - Find references
			--  - Autocompletion
			--  - Symbol Search
			--  - and more!
			--
			-- Thus, Language Servers are external tools that must be installed separately from
			-- Neovim. This is where `mason` and related plugins come into play.
			--
			-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
			-- and elegantly composed help section, `:help lsp-vs-treesitter`

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map(
						"<leader>sS",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("<leader>gh", vim.lsp.buf.hover, "Hover Documentation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					-- When you move your cursor, the highlights will be cleared (the second autocommand).

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
					       })

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end

				end,
			})

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force',capabilities,require('cmp_nvim_lsp').default_capabilities())
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`tsserver`) will work just fine
				-- tsserver = {},
				--

				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							hint = { enable = true },
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
				basedpyright = {
					enabled = true,
					settings = {
						basedpyright = {
							typeCheckingMode = "basic",
              reportUnsupportedStringEscape = "off",
						},
					},
				},
				-- pyright = {
				-- 	settings = {
				-- 		python = {
				-- 			analysis = { typeCheckingMode = "off" },
				-- 			hint = { enable = true },
				-- 		},
				-- 	},
				-- },
			}

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu.
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})

			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			vim.keymap.set("n", "<leader>h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
			end, { desc = "Toggle inlay hints" })
		end,
	},
	-- {
	-- 	"nvimtools/none-ls.nvim",
	-- 	config = function()
	-- 		local nullls = require("null-ls")
	-- 		nullls.setup({
	-- 			sources = {
	-- 				nullls.builtins.diagnostics.flake8,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"ofirgall/goto-breakpoints.nvim",
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		config = function()
			local opts = {
				notify_on_error = false,
				-- format_on_save = function(bufnr)
				-- 	-- Disable "format_on_save lsp_fallback" for languages that don't
				-- 	-- have a well standardized coding style. You can add additional
				-- 	-- languages here or re-enable it for the disabled ones.
				-- 	local disable_filetypes = { c = true, cpp = true }
				-- 	return {
				-- 		timeout_ms = 1000,
				-- 		lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				-- 	}
				-- end,
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					go = { "gofumpt", "goimports", "golines" },
					-- Conform can also run multiple formatters sequentially
					-- python = { "isort", "black" },
					--
					-- You can use a sub-list to tell conform to run *until* a formatter
					-- is found.
					-- javascript = { { "prettierd", "prettier" } },
				},
			}
			require("conform").setup(opts)
			local black_formatter = vim.deepcopy(require("conform.formatters.black"))
			require("conform.util").add_formatter_args(black_formatter, {
				"--line-length",
				"120",
			}, { append = false })
			---@cast black_formatter conform.FormatterConfigOverride
			require("conform").formatters.black = black_formatter
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				-- size = function(term)
				-- 	if term.direction == "horizontal" then
				-- 		return 15
				-- 	elseif term.direction == "vertical" then
				-- 		return vim.o.columns * 0.4
				-- 	end
				-- end,
				-- open_mapping = [[<C-\>]],
				-- 		return vim.o.columns * 0.4
				-- 	end
				-- end,
				-- open_mapping = [[<C-\>]],
				hide_numbers = true,
				shade_dfiletypes = {},
				shading_factor = 2,
				start_in_insrt = true,
				insert_mappings = true,
				persist_size = true,
				direction = "horizontal",
				size = 20,
				close_on_exit = true,
				shell = vim.o.shell,
				-- float_opts = {
				-- 	border = "curved",
				-- 	winblend = 3,
				-- 	-- row = 3,
				-- 	-- col = 3,
				-- 	width = 100,
				-- 	height = 40,
				-- 	title_opts = "center",
				-- },
			})
		end,
		vim.keymap.set("n", "<C-\\>", function()
			vim.cmd("ToggleTerm")
		end),
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		-- opts = { signs = false },
		config = function()
			require("todo-comments").setup({
				merge_keywords = true,
				keywords = {
					CELL = { icon = "⚡", color = "hint" },
					CONSTRAINT = { icon = "🔒", color = "warning", alt = {"CONST", "Constraint"} },
					OBJECTIVE = { icon = "🎯", color = "info" , alt = {"OBJ","Objective"} },
				},
				-- signs = true, -- show icons in the signs column
				-- sign_priority = 8, -- sign priority
				-- -- keywords recognized as todo comments
				-- keywords = {
				-- 	FIX = {
				-- 		icon = " ", -- icon used for the sign, and in search results
				-- 		color = "error", -- can be a hex color, or a named color (see below)
				-- 		alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				-- 		-- signs = false, -- configure signs for some keywords individually
				-- 	},
				-- 	TODO = { icon = " ", color = "info" },
				-- 	HACK = { icon = " ", color = "warning" },
				-- 	WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				-- 	PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				-- 	NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				-- 	TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				-- 	CELL = { color = "hint" },
				-- },
				-- gui_style = {
				-- 	fg = "NONE", -- The gui style to use for the fg highlight group.
				-- 	bg = "BOLD", -- The gui style to use for the bg highlight group.
				-- },
				-- merge_keywords = true, -- when true, custom keywords will be merged with the defaults
				-- -- highlighting of the line containing the todo comment
				-- -- * before: highlights before the keyword (typically comment characters)
				-- -- * keyword: highlights of the keyword
				-- -- * after: highlights after the keyword (todo text)
				-- highlight = {
				-- 	multiline = true, -- enable multine todo comments
				-- 	multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				-- 	multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				-- 	before = "", -- "fg" or "bg" or empty
				-- 	keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				-- 	after = "fg", -- "fg" or "bg" or empty
				-- 	pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				-- 	comments_only = true, -- uses treesitter to match keywords in comments only
				-- 	max_line_len = 400, -- ignore lines longer than this
				-- 	exclude = {}, -- list of file types to exclude highlighting
				-- },
				-- -- list of named colors where we try to extract the guifg from the
				-- -- list of highlight groups or use the hex color if hl not found as a fallback
				-- colors = {
				-- 	error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				-- 	warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				-- 	info = { "DiagnosticInfo", "#2563EB" },
				-- 	hint = { "DiagnosticHint", "#10B981" },
				-- 	default = { "Identifier", "#7C3AED" },
				-- 	test = { "Identifier", "#FF00FF" },
				-- },
				-- search = {
				-- 	command = "rg",
				-- 	args = {
				-- 		"--color=never",
				-- 		"--no-heading",
				-- 		"--with-filename",
				-- 		"--line-number",
				-- 		"--column",
				-- 	},
				-- 	-- regex that will be used to match keywords.
				-- 	-- don't replace the (KEYWORDS) placeholder
				-- 	pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				-- 	-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
				-- },
			})
			vim.keymap.set("n", "<leader>st", function()
				vim.cmd("TodoTelescope keywords=TODO,FIX")
			end, { desc = "[S]earch [T]odo" })
			vim.keymap.set("n", "<leader>sc", function()
				vim.cmd("TodoTelescope keywords=CELL")
			end, { desc = "[S]earch [C]ell" })
		end,
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })
			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{
		"LiadOz/nvim-dap-repl-highlights",
		config = function()
			require("nvim-dap-repl-highlights").setup()
		end,
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "bash", "c", "html", "lua", "luadoc", "markdown", "vim", "vimdoc", "python", "go" },
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)
			-- require("nvim-treesitter.context").setup()

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		after = "nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 6, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 30, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 2, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
			vim.keymap.set("n", "[h", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { silent = true })
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		config = function()
			-- local palette = require("nordic.colors")
			local highlight = {
				-- "nordic_red",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				-- vim.api.nvim_set_hl(0, "nordic_red", { fg = palette.red.dim })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			require("ibl").setup({ scope = { enabled = true, show_start = true, highlight = highlight } })
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					-- if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					-- 	return
					-- end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					{
						"rafamadriz/friendly-snippets",
						config = function()
							local ls = require("luasnip")
							-- some shorthands...
							local s = ls.snippet
							-- local sn = ls.snippet_node
							local t = ls.text_node
							local i = ls.insert_node
							-- local f = ls.function_node
							-- local c = ls.choice_node
							-- local d = ls.dynamic_node
							-- local r = ls.restore_node
							-- local l = require("luasnip.extras").lambda
							-- local rep = require("luasnip.extras").rep
							-- local p = require("luasnip.extras").partial
							-- local m = require("luasnip.extras").match
							-- local n = require("luasnip.extras").nonempty
							-- local dl = require("luasnip.extras").dynamic_lambda
							-- local fmt = require("luasnip.extras.fmt").fmt
							-- local fmta = require("luasnip.extras.fmt").fmta
							-- local types = require("luasnip.util.types")
							-- local conds = require("luasnip.extras.conditions")
							-- local conds_expand = require("luasnip.extras.conditions.expand")
							require("luasnip.loaders.from_vscode").lazy_load()
							require("luasnip").add_snippets("python", {
								s("cell", {
									t({ "#CELL:" }),
									i(1, "Name Your Cell Here"),
									t({ "<CELL>", "" }),
									i(2, ""),
									t({ "", "#</CELL>" }),
								}),
								s("visi", {
									t({ "from visidata import vd" }),
								}),
							})
							require("luasnip").add_snippets("all", {
								s("vd", {
									t("vd.view_pandas("),
									i(1, "Df"),
									t(")"),
								}),
                s("col", {
                  t({"print("}),
                  i(1, "df_name"),
                  t({".columns)"}),
                }),
                s("dtype", {
                  t({"print("}),
                  i(1, "df_name"),
                  t({".dtypes)"}),
                }),
                s("head", {
                  t({"print("}),
                  i(1, "df_name"),
                  t({".head("}),
                  i(2, "row number"),
                  t({"))"}),
                }),
                s("type", {
                  t({"print(type("}),
                  i(1, "var"),
                  t({")"}),
                }),
                s("relationship", {
                  t({"relationship (\""}),
                  i(1, "ClassName"),
                  t({"\", back_populates=\""}),
                  i(2, "ClassAttr"),
                  t({"\",cascade=\"all, delete-orphan\")"}),
                }),
							})
							require("luasnip").add_snippets("lua", {
								s("config", {
									t({ "config = function()", "" }),
									i(1, "  insert your config here."),
									t({ "", "end" }),
								}),
							})
						end,
					},
				},
			},
      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local function border(hl_name)
				return {
					{ "╭", hl_name }, -- 0
					{ "─", hl_name }, -- 1
					{ "╮", hl_name }, -- 2
					{ "│", hl_name }, -- 3
					{ "╯", hl_name }, -- 4
					{ "─", hl_name }, -- 5
					{ "╰", hl_name }, -- 6
					{ "│", hl_name }, -- 7
				}
			end
			vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#73DACA" })
			vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#73DACA" })
			vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#FF8080" })
			vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#FF8080" })
			vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#FF8080" })
			vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#73DACA" })
			vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#FFFFFF" })
			vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#FFFFFF" })
			vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#73DACA" })
			local icon = {
				Class = " Class",
				Constructor = " Constructor",
				Function = "󰡱 Function",
				Keyword = '" Keyword',
				Method = "󰢷 Method",
				Module = " Module",
				Snippet = " Snippet",
				Text = "󰊄 Text",
				Variable = "󰀫 Variable",
			}
			luasnip.config.setup({})
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				source = { { name = "path" } },
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
				formatting = {
					format = function(_, vim_item)
						vim_item.kind = icon[vim_item.kind] or ""
						return vim_item
					end,
				},
				window = {
					documentation = {
						border = border("CmpDocBorder"),
					},
				},
			})
      -- Setting up auto completion for sql files
      cmp.setup.filetype({"sql"}, {
        sources = {
          {name = "vim-dadbod-completion"},
          {name = "buffer"}
        }
      })
		end,
	},
  -- Couldn't get this working as well....
  {
    "ray-x/lsp_signature.nvim",
    opts = {},
    config = function()
      local cfg = {
          bind = true,
          doc_lines = 2,
          floating_window = true,
          hint_enable = true,
          hint_prefix = " ",
          hint_scheme = "String",
          use_lspsaga = false,
          handler_opts = { border = "single" },
          decorator = {"`", "`"}
      }
      require("lsp_signature").on_attach(cfg)
    end,
    --   vim.api.nvim_create_autocmd("LspAttach", {
    --     callback = function(args)
    --       local bufnr = args.buf
    --       local client = vim.lsp.get_client_by_id(args.client_id)
    --       if vim.tbl_contains({"null-ls"}, client.name) then -- blacklist lsp
    --         return
    --       end
    --       require("lsp_signature").on_attach({
    --         bind = true,
    --         handler_opts = {
    --           border = "rounded",
    --         },
    --         hint_enable = true,
    --         hint_prefix = " ",
    --         hint_scheme = "String",
    --         use_lspsaga = false,
    --         z_index = 50,
    --       }, bufnr)
    --     end
    --   })
    -- end

  },
	{ "kmontocam/nvim-conda" },
	-- "ubaldot/vim-conda-activate",
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({
				enabled = true,
				input_after_comment = true,
				languages = {
					python = {
						template = {
							annotation_convention = "numpydoc",
						},
					},
				},
			})
			vim.keymap.set("n", "<leader>ng", function()
				vim.cmd("Neogen")
			end, { desc = "[N]eo[g]en" })
		end,
	},
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({
				default_mappings = true,
			})
		end,
	},
	{ "norcalli/nvim-colorizer.lua" },
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.move").setup({
				mappings = {
					right = "<M-l>",
					left = "<M-h>",
					line_up = "<M-k>",
					line_down = "<M-j>",
					down = "<M-j>",
					up = "<M-k>",
				},
				options = {
					--Automatically reindent selection during linewise verical movement
					reindet_linewise = true,
				},
			})
		end,
	},
	-- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
	-- init.lua. If you want these files, they are in the repository, so you can just download them and
	-- place them in the correct locations.

	-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
	--
	--  Here are some example plugins that I've included in the Kickstart repository.
	--  Uncomment any of the lines below to enable them (you will need to restart nvim).
	--
	require("kickstart.plugins.debug"),
	-- require 'kickstart.plugins.indent_line',
	require("kickstart.plugins.lint"),
	require("wilsonchen.textobject"),
	require("wilsonchen.project"),
	require("wilsonchen.dashboard"),
	require("wilsonchen.colortheme"),
	require("wilsonchen.undo"),
	require("wilsonchen.tablemode"),
	require("wilsonchen.iron"),
	require("wilsonchen.rainbowpairs"),
	require("wilsonchen.neogit"),
	require("wilsonchen.session"),
	require("wilsonchen.copilot"),
	require("wilsonchen.lualine"),
	require("wilsonchen.undo"),
	require("wilsonchen.outline"),
	require("wilsonchen.troublemaker"),
  require("wilsonchen.refactor"),
  -- require("wilsonchen.harpoon"),
  require("wilsonchen.dadbod"),
  require("wilsonchen.bufdel"),
  require("wilsonchen.buffermanager")


	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	--    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
	-- { import = 'custom.plugins' },
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
-- Setting up colortheme.
vim.cmd.colorscheme("catppuccin-macchiato")
vim.cmd [[highlight Normal ctermbg=none guibg=none]]
vim.cmd [[highlight NonText ctermbg=none guibg=none]]
vim.cmd [[highlight LineNr ctermbg=none guibg=none]]
vim.cmd [[highlight Folded ctermbg=none guibg=none]]
vim.cmd [[highlight EndOfBuffer ctermbg=none guibg=none]]

-- vim.cmd.colorscheme("vague")
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#7f7f7f" })
-- vim.cmd.hi("Comment gui=none")
-- vim.cmd.hi("Visual guibg=#60728A")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- TODO: Git Integartion (learn how to use LazyGit)
-- TODO: Learn or maybe add pluginMuliteline cursor/edit mode  (maybe add plugin)
