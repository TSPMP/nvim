-- Plugins

-- autocommands need to be defined before vim.pack.add() is called
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and kind == 'update' then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })

vim.pack.add({
    "https://github.com/folke/which-key.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/arkav/lualine-lsp-progress",

    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lualine/lualine.nvim", -- depends on nvim-tree/nvim-web-devicons
    "https://github.com/ibhagwan/fzf-lua", -- depends on nvim-tree/nvim-web-devicons

    "https://github.com/neovim-treesitter/treesitter-parser-registry",
    "https://github.com/neovim-treesitter/nvim-treesitter", -- depends on neovim-treesitter/treesitter-parser-registry

    "https://github.com/rafamadriz/friendly-snippets",
    {src = "https://github.com/saghen/blink.cmp", version = vim.version.range('1.x')} -- depends on rafamadriz/friendly-snippets
})

-- TODO move these to separate files in plugin/lua/

require('which-key').setup { preset = 'helix' }
vim.keymap.set('n', '<Leader>?', ':lua require("which-key").show({ global = false })<Enter>', {remap=false, desc='Buffer Local Keymaps (which-key)'})
require('lualine').setup {
    sections = {
        lualine_c = {
           'filename',
           'lsp_progress'
        }
    }
}
require('fzf-lua').setup()
require('blink.cmp').setup {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'super-tab' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    cmdline = {
      keymap = {
        preset = 'cmdline',
        ['<Up>'] = {'cancel', 'fallback'},
        ['<Down>'] = {'accept', 'fallback'},
        ['<Left>'] = {'select_prev', 'fallback'},
        ['<Right>'] = {'select_next', 'fallback'}
      }
    }
}

