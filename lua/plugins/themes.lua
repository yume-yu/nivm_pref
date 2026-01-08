return  {
  {"nvim-tree/nvim-web-devicons"},
  {'MunifTanjim/nui.nvim'},
  {'rcarriga/nvim-notify'},
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    config = function ()
      -- vim.cmd([[colorscheme nightfox]])
      -- vim.cmd([[colorscheme dawnfox]])
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
    opts = function()
      return require('plugins.config.skk-mode-lualine')
    end,
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
},
{
  -- 使用していないペインを暗くする
  "tadaa/vimade",
  opts = {
    recipe = {"default", {animate = true}},
    fadelevel = 0.4,
  },
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
    }
  }
}
