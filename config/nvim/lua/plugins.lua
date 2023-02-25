-- lazy.nvim config
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  -- rich status bar
  "nvim-lualine/lualine.nvim",
  -- colorscheme
  "folke/tokyonight.nvim",
  -- rich command line
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  -- filer
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = {
      "nvim-lua/plenary.nvim"
    }
  },
  -- stylish surround selections
  "kylechui/nvim-surround",
  -- mason
  "williamboman/mason.nvim",
  -- LSP
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  -- Linters & Formatters
  "jose-elias-alvarez/null-ls.nvim",
})
