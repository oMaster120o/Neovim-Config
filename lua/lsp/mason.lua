local status_mason, mason = pcall(require, "mason")
if status_mason then
     mason.setup()
else
    print("Failed to load Mason")
end

local mason_lspconfig = require("mason-lspconfig")
local lspconfig       = require("lspconfig")

mason_lspconfig.setup_handlers({
    function(server_name)
        local capabilities = require("cmp_nvim_lsp").default_capabilities()  -- Add capabilities here
        lspconfig[server_name].setup {
            capabilities = capabilities,
        }
    end,
})
