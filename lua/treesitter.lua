require'nvim-treesitter.configs'.setup {
    matchup = {
        enable = true
    },
    indent = {
    enable = true
  },
  highlight = {
      enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

