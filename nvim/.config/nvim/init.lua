-- general settings

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- pckr bootstrap

local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
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


-- plugins

require('pckr').add{
  'nyoom-engineering/oxocarbon.nvim',
  'catppuccin/nvim',
  'bluz71/vim-moonfly-colors',
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
}


-- theming

vim.cmd("colorscheme moonfly")

-- vim: shiftwidth=2
