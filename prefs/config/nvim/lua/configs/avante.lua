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

require'avante'.setup {
  provider = "copilot",
  providers = {
    copilot = {
      model = "claude-3.7-sonnet",
    },
  },
  mappings = {
    submit = {
      insert = "<C-h>",
    },
  }
}
