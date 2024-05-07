return {
	{
		-- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		--
		-- init = function()
		-- 	-- Load the colorscheme here.
		-- 	-- Like many other themes, this one has different styles, and you could load
		-- 	-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		-- 	-- Set Backgroun to transparent
		no_italic = true,
		no_bold = true,
	},

	{
		"Mofiqul/dracula.nvim",
		opts = { colorscheme = "dracula" },
		config = function()
			local dracula = require("dracula")
			dracula.setup({
				-- customize dracula color palette
				colors = {
					bg = "#282A36",
					fg = "#F8F8F2",
					selection = "#44475A",
					comment = "#6272A4",
					red = "#FF5555",
					orange = "#FFB86C",
					yellow = "#F1FA8C",
					green = "#50fa7b",
					purple = "#BD93F9",
					cyan = "#8BE9FD",
					pink = "#FF79C6",
					bright_red = "#FF6E6E",
					bright_green = "#69FF94",
					bright_yellow = "#FFFFA5",
					bright_blue = "#D6ACFF",
					bright_magenta = "#FF92DF",
					bright_cyan = "#A4FFFF",
					bright_white = "#FFFFFF",
					menu = "#21222C",
					visual = "#3E4452",
					gutter_fg = "#4B5263",
					nontext = "#3B4048",
					white = "#ABB2BF",
					black = "#191A21",
				},
				-- show the '~' characters after the end of buffers
				show_end_of_buffer = true, -- default false
				-- use transparent background
				transparent_bg = false, -- default false
				-- set custom lualine background color
				lualine_bg_color = "#44475a", -- default nil
				-- set italic comment
				italic_comment = true, -- default false
				-- overrides the default highlights with table see `:h synIDattr`
				overrides = {},
				-- You can use overrides as table like this
				-- overrides = {
				--   NonText = { fg = "white" }, -- set NonText fg to white
				--   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
				--   Nothing = {} -- clear highlight of Nothing
				-- },
				-- Or you can also use it like a function to get color from theme
				-- overrides = function (colors)
				--   return {
				--     NonText = { fg = colors.white }, -- set NonText fg to white of theme
				--   }
				-- end,
			})
		end,
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		-- priority = 1000,
		config = function()
			local palette = require("nordic.colors")
			require("nordic").load()
			require("nordic").setup({
				override = {
					TelescopePromptTitle = {
						fg = palette.red.bright,
						bg = palette.green.base,
						italic = true,
						underline = true,
						sp = palette.yellow.dim,
						undercurl = false,
					},
				},
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				theme = "dark",
				commmentStyle = { italic = true },
				transparent = false,
				italic = false,
				underline = false,
				underline_style = "dashed",
				-- darkSidebar = false,
				-- darkFloat = false,
				-- hideInactiveStatusline = false,
				-- hideEndOfBuffer = false,
				-- statusline = "kanagawa",
				-- transparent = true,
				-- darkSidebar = true,
				-- darkFloat = true,
				-- transparent = true,
				-- italic = true,
				-- underline = true,
				-- underline_style = "dashed",
			})
		end,
	},
	{
		"https://github.com/catppuccin/nvim",
	},
}
