-- pckr setup & package installation
local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not vim.uv.fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{

        -- themes
        'bluz71/vim-moonfly-colors';
        'tiagovla/tokyodark.nvim';
        'EdenEast/nightfox.nvim';

        -- lsp
        'neovim/nvim-lspconfig';
        'hrsh7th/nvim-cmp';
        'hrsh7th/cmp-nvim-lsp';

}

-- general settings
vim.cmd [[
  set encoding=utf-8
  set termguicolors
  syntax on
  filetype plugin indent on
  let mapleader=" "

  set nobackup
  set nowritebackup
  set noswapfile
  set ruler
  set incsearch
  set modelines=0
  set nomodeline
  set wildmenu
  set nojoinspaces
  set splitbelow
  set splitright
  set number relativenumber
  set expandtab
  set autoindent
  set backspace=indent,eol,start
  set shiftround
  set cmdheight=0
  set lazyredraw

  nnoremap j gj
  nnoremap k gk

  colorscheme moonfly
]]


-- nvim-cmp setup
local cmp = require 'cmp'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-- lsp config
require'lspconfig'.jdtls.setup{
  capabilities = capabilities
}
