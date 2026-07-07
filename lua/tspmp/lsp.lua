-- LSP

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

