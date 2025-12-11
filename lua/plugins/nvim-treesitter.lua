return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    highlight = {
      enable = true,
      -- Some languages might require additional regex-based highlighting for certain features.
      -- additional_vim_regex_highlighting = { 'ruby', 'markdown' },
    },
    indent = { enable = true },
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'html',
      'lua',
      'markdown',
      'markdown_inline',
      'rust',
      'vim',
      'vimdoc',
    },
    auto_install = true,
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
