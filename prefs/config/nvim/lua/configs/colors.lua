-- Highlight Pmenu (Popup menu background, e.g., for autocompletion)
vim.api.nvim_set_hl(0, "CocFloating", {
  bg = "#06065E", -- Background: dark blue
  fg = "#FFFFFF", -- Foreground: white
})

-- Highlight CocMenuSel (Selection in Coc.nvim's completion menu)
vim.api.nvim_set_hl(0, "CocMenuSel", {
  bg = "#5F87AF", -- Background: medium blue/grey
  fg = "#FFFFFF", -- Foreground: white
})

-- Set up status line colors
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
-- Set background
vim.api.nvim_set_hl(0, "Normal", { bg = "#0d0c0b", fg = "#FFFFFF" }) -- Normal text color

-- Set highlight for when in visual mode
vim.api.nvim_set_hl(0, "Visual", { bg = "#FAB52A", fg = "#222222" }) -- Visual mode highlight
