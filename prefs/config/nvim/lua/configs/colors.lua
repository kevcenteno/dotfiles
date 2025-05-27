vim.api.nvim_set_hl(0, "StatusLine", { bg = "#1C1C1C", fg = "#87D700" })
vim.api.nvim_create_augroup("StatuslineModeHighlight", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  group = "StatuslineModeHighlight", -- Assign to the group created above
  callback = function()
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "#008700", fg = "#1C1C1C" })
  end,
  desc = "Change StatusLine to Insert mode colors", -- Optional description
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = "StatuslineModeHighlight", -- Assign to the same group
  callback = function()
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "#1C1C1C", fg = "#87D700" })
  end,
  desc = "Revert StatusLine to Normal mode colors", -- Optional description
})
