require("tree-sitter-manager").setup({
  auto_install = true,
  -- Use built-in Neovim treesitter parsers
  noauto_install = {
    "c", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc"
  },
})
