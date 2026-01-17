return  {
  'vim-denops/denops.vim',
  'Shougo/pum.vim',
  {
    'airblade/vim-gitgutter',
    config = function()
      vim.g.gitgutter_map_keys = 0
    end
  },
  'tpope/vim-fugitive',
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup({
        calm_down = true,
      })
      local kopts = {noremap = true, silent = true}
      vim.api.nvim_set_keymap('n', 'n',
      [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts)
      vim.api.nvim_set_keymap('n', 'N',
      [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    opts = {},
  },
  {
    'vim-skk/skkeleton',
    dependencies = { {'vim-denops/denops.vim'} },
    config = function()
      
      -- 1. 辞書の保存先とURLを定義
      local skk_dir = vim.fn.expand('~/.config/nvim/dict')
      local dicts = {
        "SKK-JISYO.L",
        "SKK-JISYO.jinmei",
        "SKK-JISYO.geo",
        "SKK-JISYO.station",
      }
      local dict_paths = {}

      local function prepare_dictionaries(names, dir)
        local paths = {}
        
        for _, name in ipairs(dicts) do
          local path = skk_dir .. "/" .. name
          local url = "https://skk-dev.github.io/dict/" .. name .. ".gz"

          if vim.fn.filereadable(path) == 0 then
            print("SKK辞書をダウンロード中: " .. name .. " ...")
            local cmd = string.format(
              "curl -L -o %s.gz %s && gzip -d %s.gz",
              path, url, path
            )
            vim.fn.system(cmd)
          end

          -- 存在確認などを経たパスをリストに追加
          table.insert(paths, path)
        end

        return paths
      end

      -- 実行してパスリストを取得
      local dict_paths = prepare_dictionaries(dict_names, skk_dir)

      vim.fn['skkeleton#config']({
        globalDictionaries =  dict_paths,
        eggLikeNewline = true,
      })
      -- 特定の記号を半角で入力できるようにする
      vim.fn["skkeleton#register_kanatable"]("rom", {
        ["!"] = {"!"},
        ["?"] = {"?"},
        [":"] = {":"},
        [";"] = {";"},
      })
      vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(skkeleton-enable)', {noremap = true})
      vim.api.nvim_set_keymap('c', '<C-j>', '<Plug>(skkeleton-enable)', {noremap = true})
      vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>(skkeleton-disable)', {noremap = true})
      vim.api.nvim_set_keymap('c', '<C-l>', '<Plug>(skkeleton-disable)', {noremap = true})
      vim.api.nvim_set_keymap('t', '<C-;>', '<Plug>(skkeleton-toggle)', {noremap = true})
      vim.api.nvim_set_keymap('c', '<C-;>', '<Plug>(skkeleton-toggle)', {noremap = true})
      vim.api.nvim_set_keymap('i', '<C-;>', '<Plug>(skkeleton-toggle)', {noremap = true})
    end
  },
  {
    "delphinus/skkeleton_indicator.nvim",
    dependencies = { {'vim-skk/skkeleton'} },
    opts = {} 
  },
  {
    -- 使用していないペインを暗くする
    "tadaa/vimade",
    opts = {
      recipe = {"default", {animate = true}},
      fadelevel = 0.4,
    }
  },
  -- ファイラ
  { 
    'nvim-mini/mini.files', 
    version = '*',
    config = true,
    keys = {
      { "<Leader>ft", "<cmd>lua MiniFiles.open()<CR>" },
    },
  },
}
