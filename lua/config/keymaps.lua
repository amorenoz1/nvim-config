vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files", noremap = true, silent = true })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep", noremap = true, silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List buffers", noremap = true, silent = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags", noremap = true, silent = true })

-- Esc Binding
map("i", "jk", "<Esc>", { desc = "Exit insert mode", noremap = true, silent = true })

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer", noremap = true, silent = true })

-- LSP Keybindings
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol", noremap = true, silent = true })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action", noremap = true, silent = true })
map("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Go to definition", noremap = true, silent = true })
map("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "Go to declaration", noremap = true, silent = true })
map("n", "<leader>li", vim.lsp.buf.implementation, { desc = "Go to implementation", noremap = true, silent = true })
map("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "Type definition", noremap = true, silent = true })
map("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover info", noremap = true, silent = true })
map("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "Signature help", noremap = true, silent = true })
map("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, { desc = "Format buffer", noremap = true, silent = true })
map("n", "<leader>ll", "<cmd>LspInfo<CR>", { desc = "LSP info", noremap = true, silent = true })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic", noremap = true, silent = true })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic", noremap = true, silent = true })
map("n", "<leader>le", vim.diagnostic.open_float, { desc = "Show line diagnostics", noremap = true, silent = true })
map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist", noremap = true, silent = true })

-- Bufferline Navigation
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer", noremap = true, silent = true })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer", noremap = true, silent = true })
map("n", "<leader>bd", function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.cmd("BufferLineCycleNext")  -- go to next buffer
    vim.cmd("bdelete " .. bufnr)    -- delete previous
end, { desc = "Smart close current buffer", noremap = true, silent = true })

map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers", noremap = true, silent = true })
map("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer", noremap = true, silent = true })
map("n", "<leader>bl", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right", noremap = true, silent = true })
map("n", "<leader>bh", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left", noremap = true, silent = true })


-- Debugging controls
map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Continue / Start Debugging" })
map("n", "<leader>dn", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Step Over" })
map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Step Into" })
map("n", "<leader>do", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Step Out" })
map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
map("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", { desc = "Open Debug REPL" })
map("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", { desc = "Toggle DAP UI" })

