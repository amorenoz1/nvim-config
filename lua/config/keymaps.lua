
local map = vim.keymap.set
map("i", "jk", "<Esc>", { desc = "Exit insert mode", noremap = true, silent = true })

-- nvim-tree.lua
map("n", "<leader>tt", ":NvimTreeToggle<CR>", { desc = "Toggle file tree", noremap = true, silent = true})
map("n", "<leader>tr", ":NvimTreeRefresh<CR>", { desc = "Refresh file tree", noremap = true, silent = true})
map("n", "<leader>tl", ":NvimTreeResize +10<CR>", { desc = "Resize file tree +10w", noremap = true, silent = true})
map("n", "<leader>th", ":NvimTreeResize -10<CR>", { desc = "Resize file tree -10w", noremap = true, silent = true})

-- telescope
map("n", "<leader>ff", require("telescope.builtin").find_files, {desc = "Telescope find files", noremap = true, silent = true})
map("n", "<leader>fg", require("telescope.builtin").live_grep, {desc = "Telescope live grep", noremap = true, silent = true})
map("n", "<leader>fb", require("telescope.builtin").buffers, {desc = "Telescope buffers", noremap = true, silent = true})
map("n", "<leader>fh", require("telescope.builtin").help_tags, {desc = "Telescope help tags", noremap = true, silent = true})
