nnoremap <silent><buffer><expr> <CR>
      \ denite#do_map('do_action')
nnoremap <silent><buffer><expr> d
      \ denite#do_map('do_action', 'delete')
nnoremap <silent><buffer><expr> p
      \ denite#do_map('do_action', 'preview')
nnoremap <silent><buffer><expr> <Tab>
      \ denite#do_map('choose_action')
nnoremap <silent><buffer><expr> q
      \ denite#do_map('quit')
nnoremap <silent><buffer><expr> i
      \ denite#do_map('open_filter_buffer')
nnoremap <silent><buffer><expr> <Space>
      \ denite#do_map('toggle_select').'j'
" 一つ上のディレクトリを開き直す
inoremap <silent><buffer><expr> <BS>    denite#do_map('move_up_path')
" Denite を閉じる
inoremap <silent><buffer><expr> <C-c>   denite#do_map('quit')
nnoremap <silent><buffer><expr> <C-c>   denite#do_map('quit')

