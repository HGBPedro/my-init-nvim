-- installed packages on pacman
-- fd
-- ripgrep
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 4

vim.cmd 'colorscheme silmarillion'

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('norcalli/nvim-colorizer.lua')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' }) 
Plug('neovim/nvim-lspconfig')
Plug('ms-jpq/coq_nvim')
vim.call('plug#end')

local lualine_silmarillion = require('colors.lualine_silmarillion')
require('lualine').setup {
  options = {
    theme = lualine_silmarillion,
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = {'filetype'},
    lualine_y = {'branch'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
}

require('colorizer').setup ({})
require('nvim-treesitter.configs').setup({
	ensure_installed = { "c", "javascript", "typescript", "bash", "python", "lua", "css", "scss", "json", "php", "tsx" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true
	}
})

vim.g.coq_settings = { 
	auto_start = 'shut-up',
	keymap = { eval_snips = '<leader>j' }
}
local lsp = require('lspconfig')
local coq = require('coq')

lsp.tsserver.setup(coq.lsp_ensure_capabilities({
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	init_options = {
  		hostInfo = "neovim"
	},
	single_file_support = true
}))

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

