" histsess.vim - A plugin for managing history and session
" Maintainer:   Jinghui Hu <hujinghui@buaa.edu.cn>
" Version:      0.1
"
 
if exists('g:loaded_histsess') || &compatible
  finish
else
  let g:loaded_histsess = 'yes'
endif

let g:hs_recentf_ignore_list = [
      \ "fugitive:.*",
      \ ".*Users.*",
      \ ".*vim91.*",
      \ ]

function! s:hs_browse_recent_files()
  " ignore some pattern 
  for ig in g:hs_recentf_ignore_list
    let pred = 'v:val !~# "'. ig .'"'
    " PP pred
    call filter(v:oldfiles, pred)
  endfor
  " browse oldfiles
  execute 'browse oldfiles'
endfunction

command! -nargs=0 Mbrold call s:hs_browse_recent_files()

" vim:set et sw=2:
