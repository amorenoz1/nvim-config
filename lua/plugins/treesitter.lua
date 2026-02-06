return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
       require("nvim-treesitter").install{"rust", "java", "javascript", "lua", "python", "c", "cpp", "asm", "go"}
    end,
}
