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
]]


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
}
