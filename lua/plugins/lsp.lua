-- lsp_auto.lua
-- Neovim 0.11+ LSP + Autocompletion (NO lspconfig require)

return {

    -- Mason
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = true,
    },

    -- Mason LSP bridge
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                "clangd",
                "lua_ls",
                "pyright",
                "ts_ls",
                "html",
                "cssls",
                "bashls",
            },
        },
    },

    -- LSP core (no require("lspconfig"))
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "folke/neodev.nvim",
        },
        config = function()
            require("neodev").setup()

            local capabilities =
            vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            local on_attach = function(_, bufnr)
                local opts = { buffer = bufnr, silent = true }

                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {desc = "Go to definition", buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {desc = "Go to references", buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, {desc = "Hover", buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,{desc = "Rename", buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,{desc = "Code action", buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev,{desc = "Go to prev diagnostic", buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next,{desc = "Go to next diagnostic", buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set('n', '<leader>ds', vim.diagnostic.open_float,{desc = "Show diagnostic", buffer = bufnr, noremap = true, silent = true })
            end

            -- Lua
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                    },
                },
            })

            -- TypeScript / JavaScript
            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- Other servers
            for _, server in ipairs({
                "asm_lsp",
                "clangd",
                "jdtls",
                "gopls",
                "rust_analyzer",
                "neocmake",
                "pyright",
                "html",
                "cssls",
                "bashls",
            }) do
            vim.lsp.config(server, {
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end
    end,
},

-- Snippets
{
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
},

-- Autocompletion
{
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            },
        })
    end,
},
}

