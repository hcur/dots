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
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
}

vim.cmd("colorscheme oxocarbon")

-- vim: shiftwidth=2
