"dein Scripts-----------------------------
if &compatible
	set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/yume_yu/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/yume_yu/.cache/dein')
	call dein#begin('/Users/yume_yu/.cache/dein')

	" Let dein manage dein
	" Required:
	call dein#add('/Users/yume_yu/.cache/dein/repos/github.com/Shougo/dein.vim')

	" Add or remove your plugins here like this:
	let g:rc_dir    = expand('~/.config/nvim/rc')
	let s:toml      = g:rc_dir . '/dein.toml'
	let s:lazy_toml = g:rc_dir . '/plugins_lazy.toml'
	" TOML を読み込み、キャッシュしておく
	call dein#load_toml(s:toml,      {'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})

	" Required:
	call dein#end()
	call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
	call dein#install()
endif

"End dein Scripts-------------------------
"基本の挙動-------------------------------
set backspace=indent,eol,start	"Ins時のbackspaseの挙動をいつもどおりにする
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set clipboard=unnamed           "クリップボード共有の有効化
let b:did_ftplugin = 1
"set foldmethod=indent           "折りたたみ有効化
set cursorline                  "カーソル行のハイライト表示
set number                      "行番号の表示
let g:netrw_dirhistmax = 0      "ファイル変更履歴 .netrwhistを生成しないようにする
set showmatch                   "カッコを打ったとき対応するカッコに一瞬カーソルを合わせる
set matchtime=1                 "カーソルを合わせる時間(0.1sにかける倍数)
set display=lastline            "長過ぎる行が現れたときにvim上にしっかり表示されるようにする
set tabstop=2
set expandtab
set tabstop=2
set shiftwidth=2
set hidden                      "バッファを保存せずに切り替えられるようにする
"分割した画面間の移動をCtrl+hjklに置き換え
nnoremap <C-j> <C-w><Down>
nnoremap <C-k> <C-w><Up>
nnoremap <C-l> <C-w><Right>
nnoremap <C-h> <C-w><Left>

"ウィンドウ最大化を再マッピング
nnoremap <c-w>h <C-w>H
nnoremap <c-w>j <C-w>J
nnoremap <c-w>k <C-w>K
nnoremap <c-w>l <C-w>L

"タブ移動をマッピング
nnoremap <c-n> <C-PageUp>

"Windowサイズの自動調整をoffに
set noequalalways

"インクリメント/デクリメントを+/-に置換
nnoremap + <C-a>
nnoremap - <C-x>
"yの挙動をdと合わせる
nnoremap Y 0v$hy
"jjでインサート脱出
inoremap <silent> jj <ESC>
"no hilightを簡略化
nnoremap <silent> nh :<c-u>noh<CR>

"見栄え-----------------------------------
"背景色をターミナルに統一
highlight Normal ctermbg=none
highlight LineNr ctermbg=none
highlight Nontext ctermbg=none
set list
set listchars=tab:»-,trail:-,nbsp:%,eol:↲
set termguicolors    " ターミナルでも True Color を使えるようにする。
set pumblend=10      " 0 〜 100 が指定できます。ドキュメントによると 5 〜 30 くらいが適当だそうです。
"新しいウィンドウを開くとき左ではなく右にする
language C " 言語を英語に
".vueファイルのときシンタックスがおかしくなるのを解消
autocmd FileType vue syntax sync fromstart

"文字コード/改行文字周り------------------
"エンコードの設定
set encoding=utf-8
"ファイルのエンコードの設定
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,
"ファイルの改行絡み
set fileformat=unix
set fileformats=unix,dos,mac

"外部連携周り-----------------------------
"pythonの有効化
let g:python_host_prog  = '/Users/yume_yu/.pyenv/versions/py2neovim/bin/python2'
let g:python3_host_prog = '/Users/yume_yu/.pyenv/versions/py3neovim/bin/python3'
"nodeの有効化
let g:node_host_prog = '/Users/yume_yu/.nodenv/versions/12.0.0/bin/neovim-node-host'
"rubyの有効化
let g:ruby_host_prog = '/Users/yume_yu/.rbenv/versions/2.6.3/bin/neovim-ruby-host'


