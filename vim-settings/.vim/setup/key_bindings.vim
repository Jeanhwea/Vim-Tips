" :map  -> for the modes Normal, Insert, Visual and Command-line
" :imap  -> for the Insert mode
" :cmap  -> for the Command-line mode
" :nmap  -> for the Normal mode
" :vmap  -> for the Visual mode

:map <F5> <ESC>:w<CR>:! python % <CR>
:map <F4> <ESC>:w<CR>:r ! python % <CR>
