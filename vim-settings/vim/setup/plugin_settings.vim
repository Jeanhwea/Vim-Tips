" vim:set foldmethod=marker:
" this is a private vim config file
" add this file to your .vimrc by add command as following
"   source /path/to/this/file

" pathogen {{{1
exec pathogen#infect() 
" }}}
" repeat {{{1
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" gundo {{{1
nmap <F5> :GundoToggle<CR>
" }}}
" figitive {{{1
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" }}}
" utilsnips {{{1
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
