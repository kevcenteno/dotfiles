local opt = vim.opt

opt.termguicolors = true
opt.autoindent = true
opt.backspace = { "indent", "eol", "start" }
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.number = true
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.cursorline = true
opt.timeoutlen = 300
opt.ttimeoutlen = 100
opt.visualbell = true
opt.ruler = true
opt.scrolloff = 2
opt.laststatus = 2
opt.list = true
opt.listchars = { tab = ">-" }
opt.foldenable = false
opt.wildmenu = true
opt.wildmode = { "list", "longest", "full" }
opt.wildignore:append({ "*/node_modules/*", "*/bower_components/*", "*/.tmp/*", "*/dist/*", "*.tgz", "*.gz" })
opt.updatetime = 300
opt.signcolumn = "yes"
opt.mouse = ""
opt.colorcolumn = "100"
opt.completeopt = { "menuone", "noinsert", "noselect" }

vim.filetype.add({ extension = { gohtml = "gohtmltmpl" } })

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local set_hl = vim.api.nvim_set_hl
    set_hl(0, "SignColumn", { bg = "#1c1c1c" })
    set_hl(0, "VertSplit", { bg = "#1c1c1c" })
    set_hl(0, "ColorColumn", { bg = "#3a3a3a" })
    set_hl(0, "LineNr", { bg = "#1c1c1c", fg = "#585858" })
    set_hl(0, "CursorLineNr", { bg = "#1c1c1c", fg = "#d7d7d7" })
    set_hl(0, "CursorLine", { bg = "#1c1c1c" })
    set_hl(0, "StatusLineNC", { bg = "#444444", fg = "#000000" })
    set_hl(0, "IncSearch", { bg = "#000000", fg = "#ffff00" })
    set_hl(0, "Search", { bg = "#000000", fg = "#ff0000" })
    set_hl(0, "Visual", { bg = "#ffff00", fg = "#000000" })
    set_hl(0, "SpellBad", { bg = "#000000", fg = "#ff0000" })
  end,
})
