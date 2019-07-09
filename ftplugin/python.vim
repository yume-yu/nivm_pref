if exists("b:did_ftplugin_python")
  finish
endif
let b:did_ftplugin_python=1

setlocal ai
setlocal smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class
setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
