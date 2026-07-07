-- Languages

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

