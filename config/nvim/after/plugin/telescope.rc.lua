local builtin = require('telescope.builtin')
-- n: normal mode
-- vim.keymap.set == nnoremap
vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files({
    hidden = true,
    initial_mode = "normal",
  })
end)
