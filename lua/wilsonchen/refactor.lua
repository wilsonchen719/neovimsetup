return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup({ show_success_message=true, })
      vim.keymap.set(
        "n",
        "<leader>rp",
        function()
          require("refactoring").debug.printf({below=true})
        end
      )
    end,
}
