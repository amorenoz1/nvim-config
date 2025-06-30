return {
    -- DAP Core + UI
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            -- Optional C++ example:
            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
            }

            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = true,
                },
            }
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",

        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },

    -- Mason DAP integration
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "cppdbg", "python" },
                automatic_installation = true,
            })
        end,
    },
    -- none-ls
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    -- Python
                    null_ls.builtins.diagnostics.flake8,

                    -- C/C++
                    null_ls.builtins.diagnostics.cpplint,

                    null_ls.builtins.diagnostics.checkstyle,

                    null_ls.builtins.diagnostics.golangci_lint,
                },
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function()
                    vim.lsp.buf.format({ timeout_ms = 2000 })
                end,
            })
        end,
    },

    -- Noice
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            })
        end
    },

    -- Theme
    {
        "vague2k/vague.nvim",
        config = function()
            require("vague").setup({
                -- optional configuration here
            })
            vim.cmd("colorscheme vague")
        end
    },
    -- UI
    { "nvim-lualine/lualine.nvim", config = true },
    { "nvim-tree/nvim-tree.lua",   dependencies = { "nvim-tree/nvim-web-devicons" }, config = true },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup()
        end,
    },

    -- Telescope
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                highlight = { enable = true },
                ensure_installed = { "c", "cpp", "lua", "python", "java", "bash" },
            }
        end
    },

    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    diagnostics = "nvim_lsp",
                    separator_style = "slant",
                    show_buffer_close_icons = true,
                    show_close_icon = false,
                    offsets = {
                        { filetype = "NvimTree", text = "File Explorer", text_align = "center" },
                    },
                },
            })
            vim.opt.termguicolors = true
        end,
    },

    -- Mason package manager
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason LSPconfig bridge (auto installs servers)
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "pyright", "jdtls", "bashls", "lua_ls" },
                automatic_installation = true,
            })
        end,
    },

    -- Your existing LSP config plugin here if you have one
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lspconfig = require("lspconfig")

            -- Example configuring clangd with default settings
            lspconfig.clangd.setup({})
            lspconfig.pyright.setup({})
            lspconfig.jdtls.setup({})
            lspconfig.bashls.setup({})
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })
        end,
    },
    -- LSP + Autocompletion
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("config.lsp")
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("config.cmp")
        end,
    },

    -- Optional: LSP UI improvements
    { "glepnir/lspsaga.nvim",          event = "LspAttach",                        config = true },
}
