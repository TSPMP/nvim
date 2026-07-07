-- Keymaps

-- TODO move these to FzfLua plugin file
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
vim.keymap.set('n', '<Leader>S', function() local buf_name = vim.api.nvim_buf_get_name(0) local buf_dir = vim.fn.fnamemodify(buf_name, ':p:h') FzfLua.live_grep({cwd = buf_dir}) end, {remap=false, desc='Search next to current buffer'})
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

