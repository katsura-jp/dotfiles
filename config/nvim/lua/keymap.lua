local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<S-Right>", "<Nop>")
vim.keymap.set("n", "<S-Left>", "<Nop>")
vim.keymap.set("n", "q:", "<Nop>")
vim.keymap.set("i", "<C-Space>", "<Nop>")

vim.keymap.set("i", "<C-a>", "<HOME>", opts)
vim.keymap.set("i", "<C-e>", "<END>", opts)
vim.keymap.set("n", "<C-a>", "<HOME>", opts)
vim.keymap.set("n", "<C-e>", "<END>", opts)

