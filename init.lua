vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors    = true
vim.opt.cursorline       = true
vim.opt.number           = true
vim.opt.showcmd          = true
vim.opt.autowrite        = true
vim.cmd("set expandtab")
vim.cmd("set tabstop=8")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "


vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d',       vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d',       vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.keymap.set('n', 'K',        vim.lsp.buf.hover, opts)


--Lazy Vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then vim.fn.system ({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
  }) end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

-- COLORSCHEME
vim.cmd("colorscheme solarized-osaka-night")


--MASON
require("mason").setup()
require("mason-lspconfig").setup()

--LSP CONFIG =========================================================================================
local lspconfig    = require('lspconfig')
local util         = require "lspconfig/util"

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.pylsp.setup
{
  capabilities = capabilities,
  filetypes    = {'python', 'py'},
}

lspconfig.lua_ls.setup
{
  capabilities = capabilities,
  filetypes    = {'lua'},
}

lspconfig.clangd.setup
{
  capabilities = capabilities,
  filetypes    = {'c', 'cpp', 'c++'},
}

lspconfig.jsonls.setup
{
  capabilities = capabilities,
  filetypes    = {'json'},
}

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  filetypes    = {'rust', 'rs'},
  root_dir     = util.root_pattern('Cargo.toml'),
  settings     =
  {
    ['rust-analyzer'] =
    {

      cargo =
      {
        allFeatures = true,
      },

    },
  },
})


local LSP_Complete = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'pylsp', 'rust_analyzer', 'jsonls', 'lua_ls' }
for _, lsp in ipairs(servers) do
  LSP_Complete[lsp].setup
  {
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup
{
  snippet =
  {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert ({
    ['<C-d>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>']      = cmp.mapping.confirm
    {
      behavior    = cmp.ConfirmBehavior.Replace,
      select      = true,
    },

    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()

      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()

      else
        fallback()
      end

    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)

      if cmp.visible() then
        cmp.select_prev_item()

      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)

      else
        fallback()

      end
    end, { 'i', 's' }),
  }),

  sources = cmp.config.sources ({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }),

}


--KEYMAPS ============================================================================================

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep,  {})
vim.keymap.set('n', '<leader>fb', builtin.buffers,    {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags,  {})
