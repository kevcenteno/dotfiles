require'copilot'.setup {
  filetypes = {
    ["*"] = true,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
  },
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "<C-h>",
    }
  }
}

require('render-markdown').setup {
  file_types = { "Avante" },
}

require'avante'.setup {
  provider = "copilot",
  providers = {
    copilot = {
      model = "gemini-2.5-pro",
    },
  },
  mappings = {
    submit = {
      insert = "<CR>",
    },
  },
  windows = {
    position = "left",
  },
}
