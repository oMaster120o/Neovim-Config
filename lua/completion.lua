local _lspconfig   = require("lspconfig")
local luasnip      = require("luasnip")
local cmp          = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { "asm_lsp", "clangd", "pylsp", "rust_analyzer", "jsonls", "lua_ls" }

for _, lsp in ipairs(servers) do

  _lspconfig[lsp].setup
  {
    capabilities = capabilities,
  }

end


cmp.setup
{

  sources = cmp.config.sources ({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),

  snippet =
  {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  completion = {
        completeopt = "menu,menuone,noinsert",
    },

  mapping = cmp.mapping.preset.insert ({
    ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"]      = cmp.mapping.confirm

    {
      behavior    = cmp.ConfirmBehavior.Replace,
      select      = true,
    },


    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()

      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()

      else
        fallback()
      end

    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)

      if cmp.visible() then
        cmp.select_prev_item()

      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)

      else
        fallback()

      end
    end, { "i", "s" }),
  }),


}
