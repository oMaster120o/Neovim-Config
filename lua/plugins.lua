
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then vim.fn.system ({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
  }) end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  {"williamboman/mason.nvim"},
  {"williamboman/mason-lspconfig.nvim"},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-cmdline'},
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},
  {"nvim-tree/nvim-tree.lua", version = "*", lazy = false, dependencies = {"nvim-tree/nvim-web-devicons"},
  config = function()
    require("nvim-tree").setup {}
  end
  },

  -- Snippets
  {"L3MON4D3/LuaSnip", version = "v2.*",  build = "make install_jsregexp", dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" }},

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {"ellisonleao/gruvbox.nvim"},
  {"craftzdog/solarized-osaka.nvim", lazy = false, priority = 1000},
  Config = function()

    require("osaka").setup ({

      opts =
      {
          transparent = true,
          terminal_colors = true,
          styles =
          {
            sidebars = "transparent",
            floats = "dark",
          }
       }

    })
  end,


})
