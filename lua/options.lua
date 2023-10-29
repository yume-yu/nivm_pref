vim.g.python_host_prog = '/Users/yume_yu/.pyenv_arm64/versions/py3neovim/bin/python'
vim.g.python3_host_prog = '/Users/yume_yu/.pyenv_arm64/versions/py3neovim/bin/python'
-- nodeの有効化
vim.g.node_host_prog = '/Users/yume_yu/.nodenv/versions/18.2.0/bin/neovim-node-host'
-- rubyの有効化
vim.g.ruby_host_prog = '/Library/Ruby/Gems/2.6.0/gems/neovim-0.9.0/exe/neovim-ruby-host'
-- perlの無効化
vim.g.loaded_perl_provider = 0

-- 基本設定
-- カーソルの左右移動で行末から次の行の行頭への移動を可能にする
vim.opt.whichwrap:append('b,s,h,l,<,>,[,],~')
-- Ins時のbackspaseの挙動をいつもどおりにする
vim.opt.backspace:append('indent,eol,start')
vim.opt.clipboard="unnamedplus"
vim.api.nvim_buf_set_var(0, "did_ftplugin", 1)
vim.opt.cursorline=true
vim.opt.number=true
vim.opt.mouse=nil
vim.opt.showmatch=true
vim.opt.matchtime=1
vim.opt.display="lastline"
vim.opt.tabstop=2
vim.opt.expandtab=true
vim.opt.shiftwidth=2
vim.opt.hidden=true
vim.opt.spelllang="en,cjk"
vim.opt.spell=true
vim.opt.equalalways=false
vim.opt.laststatus=2

-- 見栄え
-- 背景色をターミナルに統一
vim.opt.list=true
vim.opt.listchars="tab:»-,trail:-,nbsp:%,eol:↲"
vim.opt.termguicolors=true
vim.opt.pumblend=10      -- 0 〜 100 が指定できます。ドキュメントによると 5 〜 30 くらいが適当だそうです。
-- ポップアップの透明度を設定
vim.opt.pumblend=30

-- 文字コード/改行文字周り
-- エンコードの設定
vim.opt.encoding="utf-8"
-- ファイルのエンコードの設定
vim.opt.fileencodings="utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932"
-- ファイルの改行絡み
vim.opt.fileformat="unix"
vim.opt.fileformats="unix,dos,mac"
