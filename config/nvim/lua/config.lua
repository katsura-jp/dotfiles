-- encoding
vim.scriptencoding = 'UTF-8'
vim.o.encoding = 'UTF-8'

-- termguicolors for nvim-notify
vim.opt.termguicolors = true
-- colorscheme
vim.cmd.colorscheme "tokyonight"
-- charactor size
vim.o.ambiwidth = single
-- mute
vim.o.belloff = all
-- tab
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
-- line number
vim.o.number = true
-- uncase
vim.o.ignorecase = true
vim.o.smartcase = true
-- highlight
vim.o.cursorline = true
vim.o.cursorlineopt = 'number'
vim.o.showmatch = true
-- search
vim.o.incsearch = true
vim.o.wrapscan = true
vim.o.hls = true
-- replace
vim.o.inccommand = 'split'
vim.o.list = true
-- autoindent
vim.o.autoindent = true
vim.o.smartindent = true
-- remove backup files
vim.b.noswapfile = true
vim.b.nobackup = true
vim.b.nowritebackup = true
-- undo
vim.bo.undofile = true
-- modifiable
vim.o.modifiable = true
