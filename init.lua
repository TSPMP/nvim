-- options
vim.cmd.colorscheme('retrobox')

vim.g.mapleader = " "
vim.g.maplocalleader = "ö"

if vim.g.neovide then
	vim.o.guifont = "AdwaitaMono Nerd Font:h12"
end

vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.background = 'dark'
vim.o.textwidth = 120
vim.o.scrolloff = 5
vim.o.wrap = true
vim.o.winborder = 'rounded'
vim.o.background = 'dark'
-- whitespace
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.shiftround = true

-- global pickers
vim.keymap.set('n', '<Leader>f', ':lua FzfLua.files()<Enter>', {remap=false, desc='Search files'})
vim.keymap.set('n', '<Leader>F',
    function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        local buf_dir = vim.fn.fnamemodify(buf_name, ':p:h')
        FzfLua.files({cwd = buf_dir})
    end, {remap=false, desc='Search files next to current buffer'})
vim.keymap.set('n', '<Leader>b', ':lua FzfLua.buffers()<Enter>', {remap=false, desc='Search buffers'})
vim.keymap.set('n', '<Leader>q', ':lua FzfLua.quickfix()<Enter>', {remap=false, desc='Search quickfix'})
vim.keymap.set('n', '<Leader>l', ':lua FzfLua.loclist()<Enter>', {remap=false, desc='Search loclist'})
vim.keymap.set('n', '<Leader>/', ':lua FzfLua.lgrep_curbuf()<Enter>', {remap=false, desc='Search current buffer'})
vim.keymap.set('n', '<Leader>s', ':lua FzfLua.live_grep()<Enter>', {remap=false, desc='Search current working directory'})
vim.keymap.set('v', '<Leader>s', ':lua FzfLua.grep_visual()<Enter>', {remap=false, desc='Search selection in current working directory'})
vim.keymap.set('n', '<Leader>S',
    function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        local buf_dir = vim.fn.fnamemodify(buf_name, ':p:h')
        FzfLua.live_grep({cwd = buf_dir})
    end, {remap=false, desc='Search next to current buffer'})
vim.keymap.set('v', '<Leader>S',
    function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        local buf_dir = vim.fn.fnamemodify(buf_name, ':p:h')
        FzfLua.grep_visual({cwd = buf_dir})
    end, {remap=false, desc='Search selection next to current buffer'})
vim.keymap.set('n', '<Leader>t', ':lua FzfLua.treesitter()<Enter>', {remap=false, desc='Search treesitter nodes'})

-- cursor navigation
vim.keymap.set({'n', 'v'}, 'gs', '^', {remap=false, desc='Go to first non-blank of line'})
vim.keymap.set({'n', 'v'}, 'ge', 'G', {remap=false, desc='Go to end of buffer'})
vim.keymap.set({'n', 'v'}, 'gh', '0', {remap=false, desc='Go to start of line'})
vim.keymap.set('n', 'gl', '$', {remap=false, desc='Go to end of line'})
vim.keymap.set('v', 'gl', '$h', {remap=false, desc='Go to end of line'})
vim.keymap.set({'n', 'v'}, 'gp', '}', {remap=false, desc='Go to next paragraph'})
vim.keymap.set({'n', 'v'}, 'gP', '{', {remap=false, desc='Go to previous paragraph'})

-- windows
vim.keymap.set({'n', 'v'}, '<C-W>n', '', {remap=false}) -- delete built-in command to enable the following two
vim.keymap.set({'n', 'v'}, '<C-W>ns', ':new<Enter>', {remap=false, desc='Edit new file (horizontal split)'})
vim.keymap.set({'n', 'v'}, '<C-W>nv', ':vert :new<Enter>', {remap=false, desc='Edit new file (vertical split)'})

-- clipboard copy/paste
vim.keymap.set({'n', 'v'}, '<Leader>y', '"+y', {remap=false, desc='Yank to system clipboard'})
vim.keymap.set({'n', 'v'}, '<Leader>p', '"+p', {remap=false, desc='Paste after from system clipboard'})
vim.keymap.set({'n', 'v'}, '<Leader>P', '"+P', {remap=false, desc='Paste before from system clipboard'})

-- languages
vim.filetype.add({
  extension = {
    qnt = "quint",
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'quint',
  callback = function()
    vim.lsp.start({
      name = 'quint',
      cmd = { 'npm', 'exec', '--', 'quint-language-server', '--stdio' },
    })
  end,
})

-- treesitter

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'rust', 'python', 'typescript', 'lua' },
  callback = function()
    vim.treesitter.start() -- highlighting
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- folds
    vim.wo.foldmethod = 'expr'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
  end,
})

-- plugins
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

-- lsp
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')
local lsp_augroup = vim.api.nvim_create_augroup('TspmpLsp', {clear = true})
vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'Define keymaps for buffers with a LSP',
        group = lsp_augroup,
        callback = function(args)
            vim.keymap.set('n', '<LocalLeader>r', ':lua FzfLua.lsp_references()<Enter>', {remap=false, buffer=true, desc='List references'})
            vim.keymap.set('n', '<LocalLeader>R', ':lua vim.lsp.buf.rename()<Enter>', {remap=false, buffer=true, desc='Rename symbol'})
            vim.keymap.set('n', '<LocalLeader>a', ':lua FzfLua.lsp_code_actions()<Enter>', {remap=false, buffer=true, desc='List code actions'})
            vim.keymap.set('n', '<LocalLeader>d', ':lua FzfLua.lsp_definitions()<Enter>', {remap=false, buffer=true, desc='Go to definition'})
            vim.keymap.set('n', '<LocalLeader>s', ':lua FzfLua.lsp_document_symbols()<Enter>', {remap=false, buffer=true, desc='List document symbols'})
            vim.keymap.set('n', '<LocalLeader>i', ':lua FzfLua.lsp_implementations()<Enter>', {remap=false, buffer=true, desc='List implementations'})
            vim.keymap.set('n', '<LocalLeader>ci', ':lua FzfLua.lsp_incoming_calls()<Enter>', {remap=false, buffer=true, desc='List incoming calls'})
            vim.keymap.set('n', '<LocalLeader>co', ':lua FzfLua.lsp_outgoing_calls()<Enter>', {remap=false, buffer=true, desc='List outgoing calls'})
            vim.keymap.set('n', '<LocalLeader>p', ':lua FzfLua.diagnostics_document()<Enter>', {remap=false, buffer=true, desc='List document diagnostics'})
            vim.keymap.set('n', '<LocalLeader>P', ':lua FzfLua.diagnostics_workspace()<Enter>', {remap=false, buffer=true, desc='List workspace diagnostics'})
        end
})
