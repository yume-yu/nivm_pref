return  {
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    config = function ()
      vim.cmd([[colorscheme nightfox]])
    end
  },
  { 
    'itchyny/lightline.vim',
    dependencies = {"EdenEast/nightfox.nvim"},
    config = function()
      vim.g.lightline = { 
        colorscheme = "nightfox",
        enable = { tabline= 0 },
        separator = { left = "", right = "" },
        subseparator = { left = "", right = "" },
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("plugins/config/nvim-treesitter")
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("ibl").setup()
    end
  },
  'editorconfig/editorconfig-vim'
}
