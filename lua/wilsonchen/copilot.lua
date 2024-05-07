return {
	{ "github/copilot.vim" },
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "github/copilot.vim" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
		},
		-- See Commands section for default commands if you want to lazy load on them
		config = function()
			local keyword = "CopilotChat"
			require("CopilotChat").setup({
				window = {
					layout = "float", -- 'vertical', 'horizontal', 'float', 'replace'
					width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
					height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
					-- Options below only apply to floating windows
					relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
					border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
					row = nil, -- row position of the window, default is centered
					col = nil, -- column position of the window, default is centered
					title = "Copilot Chat", -- title of chat window
					footer = nil, -- footer of chat window
					zindex = 1, -- determines if window is on top or below other floating windows
				},
			})
			-- Setting up keymaps for Copilot.
			-- Ghost text keymappings.
			vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				silent = true,
				replace_keycodes = false,
			})
			vim.keymap.set("i", "<C-k>", "copilot#Next()", {
				expr = true,
				silent = true,
				replace_keycodes = false,
			})
			vim.keymap.set("i", "<C-l>", "copilot#Previous()", {
				expr = true,
				silent = true,
				replace_keycodes = false,
			})
			-- Chat window keymappings.
			vim.keymap.set("n", "<leader>ct", ":CopilotChatToggle<CR>", {
				noremap = true,
				silent = true,
			})
			vim.keymap.set("n", "<leader>cc", function()
				local question = vim.fn.input("Ask Copilot: ")
				if question ~= "" then
					require("CopilotChat").ask(question)
				end
			end)
			vim.g.copilot_no_tab_map = true
			-- Write me a function to copy the code block from CopilotChatToggle.
			-- vim.keymap.set("n", "<leader>cp", function()
			-- 	require("CopilotChat").copy()

			-- end)
		end,
	},
}
-- TODO: Add a keymap to copy code block in CopilotChatToggle.
