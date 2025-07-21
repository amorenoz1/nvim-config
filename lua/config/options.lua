-- Leader key must be set before plugins
vim.g.mapleader = " "

local opt = vim.opt

-- UI/Editor behavior
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.cursorline = false    -- Highlight current line
opt.signcolumn = "yes"    -- Always show the sign column
opt.scrolloff = 24        -- Keep 24 lines above/below cursor
opt.sidescrolloff = 8     -- Horizontal context

-- Cursor shape in all modes (block style)
opt.guicursor = {
    "n-v-c:block",   -- Normal, visual, command-line: block
    "i-ci-ve:block", -- Insert, insert command-line: block
    "r-cr:block",    -- Replace modes: block
    "o:hor50",       -- Operator-pending: horizontal bar
    "sm:block-blinkwait175-blinkon150-blinkoff150"
}

-- Clipboard
opt.clipboard = "unnamedplus" -- Use system clipboard for all operations

-- Tabs & Indents
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.wrap = false

-- Performance
opt.updatetime = 250
opt.timeoutlen = 400
opt.swapfile = false
opt.backup = false
opt.undofile = true

