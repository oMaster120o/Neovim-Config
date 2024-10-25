local lspconfig    = require("lspconfig")
local util         = require "lspconfig/util"
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.asm_lsp.setup
{
  capabilities = capabilities,
  cmd          = { "asm-lsp" },
  filetypes    = { "asm" }
}


lspconfig.pylsp.setup
{
  capabilities = capabilities,
  filetypes    = {"python", "py"},
  settings =
  {
    pylsp =
    {
      telemetry =
      {
        enable = false
      }
    }
  }
}


lspconfig.lua_ls.setup
{
  capabilities = capabilities,
  filetypes    = {"lua"},
}


lspconfig.clangd.setup
{
  capabilities = capabilities,
  filetypes    = {"c", "cpp", "c++", "header"},

  init_options =
  {
      clangd =
      {
          formattingStyle =
          {
              BasedOnStyle = "Google",
              BreakBeforeBraces = "Allman",
              AllowShortBlocksOnASingleLine = "Empty",
              AllowShortCaseLabelsOnASingleLine = true,
              AllowShortFunctionsOnASingleLine = "Empty",
              AllowShortIfStatementsOnASingleLine = true,
              AllowShortLoopsOnASingleLine = true,
          }
      }
  },
}


lspconfig.jsonls.setup
{
  capabilities = capabilities,
  filetypes    = {"json"},
}


lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  cmd          = { "/run/current-system/sw/bin/rust-analyzer" },
  filetypes    = {"rust", "rs"},
  root_dir     = util.root_pattern("Cargo.toml"),
  settings     =
  {
    ["rust-analyzer"] =
    {

      cargo =
      {
            allFeatures = true,
      },

      procMacro =
      {
            enable = true,
      },

      diagnostics =
      {
            enable = true,
      },

      rustfmt =
      {
            config = { formatting_style = "Allman", },
      },

    },
  },
})
