autocmd BufNewFile,BufRead *.atomlang set filetype=atomlang
autocmd BufNewFile,BufRead *.gr set filetype=atomlang
autocmd BufRead * call s:Atomlang()
function! s:Atomlang()
  if !empty(&filetype)
    return
  endif

  let line = getline(1)
  if line =~ "^#!.*atomlang"
    setfiletype atomlang
  endif
endfunction