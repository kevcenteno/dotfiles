return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(lhs, rhs, description)
            vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = description })
          end
          map("K", vim.lsp.buf.hover, "Hover documentation")
          map("gd", vim.lsp.buf.definition, "Definition")
          map("gy", vim.lsp.buf.type_definition, "Type definition")
          map("gi", vim.lsp.buf.implementation, "Implementation")
          map("gr", vim.lsp.buf.references, "References")
          map("<F2>", vim.lsp.buf.rename, "Rename")
          map("<leader>j", vim.diagnostic.goto_next, "Next diagnostic")
          map("<leader>k", vim.diagnostic.goto_prev, "Previous diagnostic")
        end,
      })
    end,
  },
}
