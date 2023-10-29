-- ddu本体の設定
vim.fn["ddu#custom#patch_global"]({
  ui =  'ff',
  sources =  {
    {name =  'file', params = {}},
    {name = 'file_rec',params = {}},
    {name = 'mr'},
    {name = 'register'},
    {name = 'buffer'},
    {name = 'line'}
  },
  sourceOptions =  {
    _ =  {
      matchers =  {'matcher_substring'},
    },
    file_rec =  {path =  vim.fn.expand("~")},
  },
  filterParams =  {
    matcher_substring =  {
      highlightMatched =  'Title',
    },
  },
  kindOptions =  {
    file =  {
      defaultAction =  'open',
    },
    action =  {
      defaultAction =  'do',
    },
  },
  uiParams =  {
    ff =  {
      startFilter = true,
      prompt =  '>',
      split =  'floating',
      displaySourceName =  'no',
      floatingBorder =  'rounded',
      filterFloatingPosition =  'top',
      previewFloating =  true,
      previewFloatingBorder =  'rounded',
      previewSplit =  'vertical',
      autoAction =  {
        delay =  3,
        name =  'preview'
      },
    },
  },
})

-- bufferのfilter
vim.fn["ddu#custom#patch_local"]('buffer', {
  ui = 'ff',
  sources = {{name = 'buffer', params = {}} },
  sourceOptions = {
    buffer ={
      columns = {'icon_filename'},
    }
  }
})

-- 開いているファイル内検索のfilter 
vim.fn["ddu#custom#patch_local"]('line', {
  ui = 'ff',
  sources = {{name = 'line', params = {}}},
  uiParams = {
    ff = {
      autoAction = {}
    }
  }
})

-- 開いているディレクトリ内のファイル検索のfilter 
vim.fn["ddu#custom#patch_local"]('file-list', {
  ui = 'ff',
  sources = {
    {
      name = 'file_rec',
      params ={
        ignoredDirectories ={
          '.git',
          '__pycache__'
        }
      } 
    }
  },
  sourceOptions = {
    file_rec ={
      path = vim.fn.expand('')
    }
  },
  uiParams = {
    ff = {
      split = 'horizontal',
      filterSplitDirection = 'botright',
      splitDirection = 'botright',
      winHeight = 10,
    }
  },
})


-- grepバッファの設定
vim.fn["ddu#custom#patch_local"]('grep', {
  sourceParams = {
    rg = {
      args = {'--column', '--no-heading', '--color', 'never'},
    },
  },
  uiParams = {
    ff = {
      startFilter = false,
    }
  },
})

-- フィルターバッファでのキーマップ
vim.api.nvim_create_autocmd(
  {'FileType'},
  {
    pattern = 'ddu-ff',
    callback = function()
      local opts = { noremap = true, silent = true }
      -- Enterでそのitemに定義されたアクション(ex. 開く など)
      vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<Cmd>call ddu#ui#ff#do_action('itemAction')<CR>", opts)
      -- Spaceでそのitemの選択/解除
      vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>", opts)
      vim.api.nvim_buf_set_keymap(0, "n", "d", "<Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'delete'})<CR>", opts)
      -- iで絞り込みバッファの展開
      vim.api.nvim_buf_set_keymap(0, "n", "i", "<Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>", opts)
      -- qでバッファを閉じる
      vim.api.nvim_buf_set_keymap(0, "n", "q", "<Cmd>call ddu#ui#ff#do_action('quit')<CR>", opts)
      -- cでアクション選択
      vim.api.nvim_buf_set_keymap(0, "n", "c", "<Cmd>call ddu#ui#ff#do_action('chooseAction')<CR>", opts)
    end
  }
)

vim.api.nvim_create_autocmd(
  {'FileType'},
  {
    pattern = 'ddu-ff-filter',
    callback = function()
      local opts = { noremap = true, silent = true }
      -- Enterでそのitemに定義されたアクション(ex. 開く など)
      vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "<esc><Cmd>call ddu#ui#ff#do_action('closeFilterWindow')<CR>", opts)
      vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<Cmd>call ddu#ui#ff#do_action('closeFilterWindow')<CR>", opts)
      -- qでバッファを閉じる
      vim.api.nvim_buf_set_keymap(0, "n", "q", "<Cmd>call ddu#ui#ff#do_action('closeFilterWindow')<CR>", opts)
    end
  }
)

-- ddu呼び出しのキーマップ
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>h", "<cmd>call ddu#start({'name': 'file-mr','sources': [{'name':'mr'}]})<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>b", "<Cmd>call ddu#start({'name': 'buffer' })<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>call ddu#start({'name': 'line' })<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>L", "<Cmd>call ddu#start({'name': 'line','input': expand('<cword>')})<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>f", "<Cmd>call ddu#start({'name': 'file-list'})<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>g", " <Cmd>call ddu#start({'name': 'grep', 'sources':[ {'name': 'rg', 'params': {'input': expand('<cword>')}} ], })<CR>", opts)
-- " build-in LSPの設定
-- " カーソル下の情報表示
-- vim.api.nvim_set_keymap("n", "<silent> [ddu]d :<c-u>lua vim.lsp.buf.hover()<CR>
-- " カーソル下の定義へジャンプ
-- vim.api.nvim_set_keymap("n", "<silent> [ddu]D :<c-u>lua vim.lsp.buf.definition()<CR>
-- " 修正の提案
-- vim.api.nvim_set_keymap("n", "<silent> [ddu]a :<c-u>lua vim.lsp.buf.code_action()<CR>
-- " 変数リネーム
-- vim.api.nvim_set_keymap("n", "<silent> [ddu]R :<c-u>lua vim.lsp.buf.rename()<CR>
-- " カーソル下の対象を参照している箇所を一覧表示
-- vim.api.nvim_set_keymap("n", "<silent> [ddu]G :<c-u>lua vim.lsp.buf.references()<CR>
-- 
