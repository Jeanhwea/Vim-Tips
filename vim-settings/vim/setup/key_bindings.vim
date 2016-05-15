" :map  -> for the modes Normal, Insert, Visual and Command-line
" :imap  -> for the Insert mode
" :cmap  -> for the Command-line mode
" :nmap  -> for the Normal mode
" :vmap  -> for the Visual mode

" python - run a python script
:nmap <leader>py <ESC>:w<CR>:! python % <CR>
" read python - run a python script output to this file
:nmap <leader>rpy <ESC>:w<CR>:r ! python % <CR>

" insert time string
imap <silent> <C-D><C-D> <C-R>=strftime("%e/%b/%Y")<CR>
imap <silent> <C-T><C-T> <C-R>=strftime("%l:%M:%p")<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>li :set list!<CR>

" Shortcut to rapidly toggle `set number`
nmap <leader>nu :set number!<CR>

" Shortcut to edit a new file in current directory
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>


