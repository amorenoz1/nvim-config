local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
    "rust_analyzer",
    "gopls",       -- Golang
    "clangd",      -- C/C++
    "pyright",     -- Python
    "jdtls",       -- Java
    "bashls",      -- Bash
    "lua_ls",      -- Lua (used by Neovim itself)
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
end

