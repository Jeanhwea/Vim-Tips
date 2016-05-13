" :map  -> for the modes Normal, Insert, Visual and Command-line
" :imap  -> for the Insert mode
" :cmap  -> for the Command-line mode
" :nmap  -> for the Normal mode
" :vmap  -> for the Visual mode

:map <F5> <ESC>:w<CR>:! python % <CR>
:map <F4> <ESC>:w<CR>:r ! python % <CR>

" insert time string
imap <silent> <C-D><C-D> <C-R>=strftime("%e/%b/%Y")<CR>
imap <silent> <C-T><C-T> <C-R>=strftime("%l:%M:%p")<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
" set listchars=tab:▸\ ,eol:¬
set listchars=tab:▸\ ,eol:☠

" Shortcut to rapidly toggle `set number`
nmap <leader>n :set number!<CR>

