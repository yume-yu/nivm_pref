-- SKKのモード状態を取得するローカル関数
local function skk_status()
  -- インサート/コマンドモード以外、またはSKK未ロード時は非表示
  if vim.fn.mode() ~= "i" and vim.fn.mode() ~= "c" and vim.fn.mode() ~= "t" then return "" end
  if vim.fn.exists("*skkeleton#mode") ~= 1 then return "" end
  
  local mode = vim.fn["skkeleton#mode"]()
  local map = {
    eiji    = "A",
    hira    = "あ",
    kata    = "ア",
    hankata = "ｱ",
    zenkaku = "Ａ",
    abbrev  = "abbr",
    [""]    = "A", -- skkeletonが動いているが直接入力の状態
  }
  return map[mode] or ""
end

-- 【追加】スクロールバーを表示する関数
local function scroll_bar()
  local curr_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_line_count(0)
  
  -- 縦のブロック（Felineっぽいのはこっちかな）
  local chars = { '  ', '  ', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
  
  -- 行数に対する割合を計算してインデックスを決定
  local i = math.floor((curr_line - 1) / lines * #chars) + 1
  return chars[i]
end

-- (上部の skk_status や scroll_bar 関数はそのまま維持)

return {
  options = {
    theme = "iceberg_dark",
    globalstatus = true,
    -- アイコンを使うなら必須（Nerd Fontsが必要）
    icons_enabled = true, 
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    -- lualine_a, lualine_b はデフォルトのままでいいなら省略可（あるいは明示してもいい）
    
    -- ここが左側のメインエリア
    lualine_c = {
      {
        'filetype',
        icon_only = true, -- これが重要。文字（luaなど）を消してアイコンだけにする
        separator = "",   -- ファイル名との間の区切り線を消して「一体感」を出す
        padding = { left = 1, right = 0 } -- 右の余白を削ってファイル名に寄せる
      },
      {
        'filename',
        path = 1, -- 0: ファイル名のみ, 1: 相対パス, 2: 絶対パス (お好みで)
      }
    },

    -- 右側
    lualine_x = {
      { skk_status, color = { fg = "#ff9e64", gui = "bold" } },
      "encoding",
      "fileformat",
    },
    
    lualine_y = { "location" },
    
    lualine_z = {
      {
        scroll_bar,
        color = { fg = "#9ece6a", },
        padding = { left = 1},
      },
    },
  },
  tabline = {
    -- 左側: 開いているバッファ（ファイル）を並べる
    lualine_a = {
      {
        'buffers',
        show_filename_only = true,   -- ディレクトリ名を含めない
        hide_filename_extension = false,
        show_modified_status = true, -- 保存されていないファイルにマークをつける
        
        -- 現在のバッファとそれ以外で見た目を変える
        buffers_color = {
          active = 'lualine_a_normal',     -- アクティブな色（テーマに従う）
          inactive = 'lualine_b_inactive', -- 非アクティブな色
        },
        
        symbols = {
          modified = ' ●',      -- 未保存マーク
          alternate_file = '',  -- 直前のファイルマーク（うるさいなら空で）
          directory =  '',     -- ディレクトリ
        },
      }
    },
    
    -- 真ん中は空けておく
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},

    -- 右側: 実際の「タブページ」があれば表示する
    -- (vimのタブ機能を使わないならここは空でもいい)
    lualine_z = {
      { 
        'tabs', 
        mode = 2, -- 0: 名前, 1: 番号, 2: 名前+番号
        -- 現在のバッファとそれ以外で見た目を変える
        tabs_color = {
          active = 'lualine_a_normal',     -- アクティブな色（テーマに従う）
          inactive = 'lualine_b_inactive', -- 非アクティブな色
        },
      } 
    }
  },
  
  -- (必要なら) 拡張機能の設定
  extensions = { 'lazy' }
}
