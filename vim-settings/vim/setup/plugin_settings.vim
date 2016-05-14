" this is a private vim config file
" add this file to your .vimrc by add command as following
"   source /path/to/this/file

" pathogen
exec pathogen#infect()

" repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" gundo
nmap <F5> :GundoToggle<CR>
