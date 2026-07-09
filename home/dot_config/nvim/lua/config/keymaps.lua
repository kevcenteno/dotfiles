local map = vim.keymap.set

map("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>s", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>,", "2<C-w><", { desc = "Narrow split" })
map("n", "<leader>.", "2<C-w>>", { desc = "Widen split" })
map("n", "<leader>-", "2<C-w>-", { desc = "Shorten split" })
map("n", "<leader>=", "2<C-w>+", { desc = "Heighten split" })
map("n", "<leader>w", "<C-w>w", { desc = "Next split" })
map({ "n", "i" }, "<F1>", "<cmd>echo<cr>", { silent = true })
map("x", ".", ":normal .<cr>", { silent = true })
map("x", "<leader>h", ":s/:\\(\\w*\\) *=>/\\1:/g<cr>", { desc = "Convert hash rockets" })
map("n", "<leader><leader>", "<C-^>", { desc = "Last buffer" })
map("n", "<C-l>", "<cmd>nohlsearch<cr>", { silent = true })
map("i", "<C-c>", "<Esc>")

vim.api.nvim_create_user_command("Plain", function()
  vim.cmd([[%s/’/'/ge | %s/[“”]/"/ge | %s/—/-/ge]])
end, {})
