return  {
  {"nvim-tree/nvim-web-devicons"},
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
  'editorconfig/editorconfig-vim',
  {
    -- 使用していないペインを暗くする
    "tadaa/vimade",
    opts = {
      recipe = {"default", {animate = true}},
      fadelevel = 0.4,
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = "75%",
            col = "50%",
          },
          size = {
            width = "60%",
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = "75%", 
            col = "50%",
          },
          size = {
            width = "60%",
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }
}
