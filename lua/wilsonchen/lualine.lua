-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		'letieu/harpoon-lualine',
	},
	config = function()
		local colors = {
		    bg = "#24283b",
		    bg_inactive = "#1f2335",
		    fg = "#c0caf5",
		    fg_inactive = "#3b4261",
		}

		local function get_buffer_list()
			local marks = require("buffer_manager").marks
			local list_bufs = ""
			for _, mark in ipairs(marks) do
				local short_name = require("buffer_manager.utils").get_short_file_name(mark.filename, {})
				list_bufs = list_bufs .. short_name .. "|"
				-- table.insert(mytable,#mytable+1, mark.filename)
				-- print(mark.filename)
			end
			return list_bufs
			-- return [[Hello World]]
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "palenight",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				-- lualine_c = {"harpoon2"},
				-- lualine_c = {
				-- 	{ 'buffers',
				-- 		 buffers_color = {
				-- 		 active = { bg = colors.bg, fg = colors.fg },
				-- 		 inactive = { bg = colors.bg_inactive, fg = colors.fg_inactive },
				-- 		}
				--   }
				-- },
				-- lualine_c = {get_buffer_list},
				lualine_w = {"tabline"},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
