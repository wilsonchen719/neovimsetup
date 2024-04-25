return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						-- Select around and inner different common objects.
						-- Parameter
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						-- Function
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						-- Class
						["ac"] = "@class.outer",
						["ic"] = "@lass.inner",
						-- Condition
						["ii"] = "@conditional.inner",
						["ai"] = "@conditional.outer",
						-- Loop
						["il"] = "@loop.inner",
						["al"] = "@loop.outer",
						-- Comment
						["at"] = "@comment.outer",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- Whether to set jumps in the jump list.
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]l"] = "@loop.*",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
					goto_previous_end = {
						["[F"] = "@function.outer,",
						["[C"] = "@class.outer",
					},
					goto_next = {
						["]i"] = "@conditional.outer",
					},
					goto_previous = {
						["[i"] = "@conditional.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>j"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>k"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
