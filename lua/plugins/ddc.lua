-- ddc.vim
-- 参考
-- Vimの新しい自動補完プラグイン「ddc.vim」を使ってみた - https://note.com/dd_techblog/n/n97f2b6ca09d8
-- Neovimの補完をddc.vim + Built-in LSP へ移行した - https://ntsk.jp/blog/ddc-vim/

return {
  {
    -- deoplateの後継?
    'Shougo/ddc.vim',
    dependencies = {'vim-denops/denops.vim', 'Shougo/pum.vim', 'vim-vsnip'},
    -- event = 'InsertEnter',
    config = function()
      vim.fn["ddc#custom#patch_global"]({
        ui = 'native',
        sources = { 'skkeleton', 'lsp','vsnip','around','file', 'dictionary', 'mocword'},
        sourceOptions = {
          _ = {
            matchers = {'matcher_fuzzy'},
            sorters = {'sorter_fuzzy'},
            converters = {'converter_remove_overlap', 'converter_fuzzy'},
            ignoreCase = 'true',
          },
          dictionary = {
            mark = 'dict',
          },
          mocword = {
            mark = 'mocword',
          },
          around = {
            mark = 'around',
          },
          vsnip = {
            mark = 'snip',
          },
          ["lsp"] = {
            mark = '[LSP]',
            dup = 'keep',
            keywordPattern = '\\k+',
            sorters = {'sorter_fuzzy'},
            --sorters = {'sorter_fuzzy', 'sorter_lsp-kind'},
            forceCompletionPattern = {'\\.\\w*|:\\w*|->\\w*'}
          },
          skkeleton = {
            mark = 'skk',
            matchers = {},
            sorters = {},
            isVolatile = true,
          },
          file = {
            mark = 'file',
            isVolatile = true,
            forceCompletionPattern = '\\S/\\S*'
          },
        },
        sourceParams = {
          around = {
            maxSize= 500
          },
          ["nvim-lsp"] = {
            snippetEngine = vim.fn["denops#callback#register"](function(body) vim.fn["vsnip#anonymous"](body) end),
            enableResolveItem = true,
            enableAdditionalTextEdit = true,
          },
          dictionary = {
            dictPaths = {
              '/usr/share/dict/words'
            },
            smartCase = true,
            isVolatile = true,
            showMenu = false,
          }

        },
      })
      -- Mappings
      -- <TAB>: completion.
      vim.cmd("inoremap <silent><expr> <TAB> pumvisible() ? '<C-n>' : vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\\s') ? '<TAB>' : ddc#map#manual_complete()")
      -- <S-TAB>: completion back.
      vim.cmd("inoremap <silent><expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'")
      vim.fn["ddc#enable"]()
    end
  },
  {
    -- ddcのsource 周辺単語
    'Shougo/ddc-around',
  },
  -- ddcのsource ファイル名
  'LumaKernel/ddc-file',
  --ddcのsource 次の英単語をサジェストする
  --need to put binary https://github.com/high-moctane/mocword
  --and put db https://github.com/high-moctane/mocword-data
  'Shougo/ddc-mocword',
  -- ddcのfilter 先頭一致
  'Shougo/ddc-matcher_head',
  -- ddcのfilter fazzy 曖昧一致
  'tani/ddc-fuzzy',
  -- ddcのfilter 候補のソート
  'Shougo/ddc-sorter_rank',
  -- ddcのfilter 重複の抑止
  'Shougo/ddc-converter_remove_overlap',
  -- ddcのui? https://scrapbox.io/takker/You_must_install_ddc_UI_plugins_and_specify_%22ui%22_option.
  'Shougo/ddc-ui-native',
  'matsui54/ddc-dictionary',
  'uga-rosa/ddc-source-vsnip',
  {
    'rafamadriz/friendly-snippets',
    lazy = true,
  },
  {
    -- snippet機能の提供
    -- 参考: https://riq0h.jp/2021/09/15/084023/#neovim-builtin-lsp
    'hrsh7th/vim-vsnip',
    -- event = 'InsertEnter',
    dependencies = {'friendly-snippets'},
    config = function()
      -- Expand
      --vim.cmd("imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'")
      --vim.cmd("smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'")

      -- Expand or jump
      --vim.cmd("imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'")
      --vim.cmd("smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'")

      vim.cmd("let g:vsnip_filetypes = {}")
    end
  },
  'neovim/nvim-lspconfig',
  'Shougo/ddc-nvim-lsp',
  --{
  --  'Shougo/ddc-source-lsp',
  --  dependencies = {'ddc-nvim-lsp'},
  --  event = 'InsertEnter',
  --  config = function()
  --    local capabilities = require("ddc_source_lsp").make_client_capabilities()
  --    vim.lsp.config.denols..setup({
  --      capabilities = capabilities,
  --    })
  --  end
  --},
  --{
  --  'Shougo/ddc-source-nvim-lsp',
  --  dependencies = {'ddc-nvim-lsp'},
  --  event = 'InsertEnter',
  --  config = function()
  --    local capabilities = require("ddc_nvim_lsp").make_client_capabilities()
  --    vim.lsp.config.denols.setup({
  --      capabilities = capabilities,
  --    })
  --  end
  --},
  -- mason 参考: https://watasuke.net/blog/article/using-lsp-completion-with-lazy-nvim-mason/
  {
    'williamboman/mason.nvim',
    lazy = true,
    build = ':MasonUpdate',
    cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
    config = true, 
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 
      {'williamboman/mason.nvim'}, 
      {"neovim/nvim-lspconfig"},
    },
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    keys = {
      { "<C-space>", "<cmd>lua vim.lsp.completion.get()  <CR>", mode = "i" },
      { "<Leader>d", "<cmd>lua vim.lsp.buf.hover()       <CR>" },
      { "<Leader>D", "<cmd>lua vim.lsp.buf.definition()  <CR>" },
      { '<Leader>a', "<cmd>lua vim.lsp.buf.code_action(bufopts)<CR>"},
      { '<Leader>R', "<cmd>lua vim.lsp.buf.rename(bufopts)<CR>"},
      { '<leader>g', "<cmd>lua vim.lsp.buf.references(bufopts)<CR>"},
      { '<Leader>F', "<cmd>lua vim.lsp.buf.format(bufopts)<CR>"},
      --{ "<Leader>D",        "<cmd>lua vim.lsp.buf.declaration() <CR>" },
    },
    --config = function()
    --  local nvim_lsp = require('lspconfig')
    --  local mason_lsp = require('mason-lspconfig')
    --  mason_lsp.setup_handlers({ function(server_name)
    --    local opts = {}
    --    opts.on_attach = function(_, bufnr)
    --      local bufopts = { silent = true, buffer = bufnr }
    --      vim.keymap.set('n', '<Leader>d', vim.lsp.buf.hover, bufopts)
    --      vim.keymap.set('n', '<Leader>D', vim.lsp.buf.definition, bufopts)
    --      vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, bufopts)
    --      vim.keymap.set('n', '<Leader>R', vim.lsp.buf.rename, bufopts)
    --      vim.keymap.set('n', '<leader>g', vim.lsp.buf.references, bufopts)
    --      vim.keymap.set('n', '<Leader>F', vim.lsp.buf.format, bufopts)
    --    end
    --    nvim_lsp[server_name].setup(opts)
    --  end })
    --end
  },
  {
    'matsui54/denops-signature_help',
    config = function()
      vim.g.signature_help_config = {
        contentsStyle ="full",
        viewStyle = "floating"
      }
      vim.g.signature_help_config = {
        contentsStyle = "remainingLabels",
        viewStyle = "virtual"
      }
      vim.fn["signature_help#enable"]()
    end
  },
  {
    'matsui54/denops-popup-preview.vim',
    config = function()
      vim.fn["popup_preview#enable"]()
    end
  }
}
