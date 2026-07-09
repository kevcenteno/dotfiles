return {
  { "tpope/vim-repeat", lazy = false },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>o", function() require("fzf-lua").git_files() end, desc = "Git files" },
    },
    opts = {},
  },
}
