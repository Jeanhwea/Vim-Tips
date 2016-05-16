" vim:set foldmethod=marker:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
"         _                          _                                   "
"        | |                        | |                                  "
"        | |   ___    __ _   _ __   | |__   __      __   ___    __ _     "
"    _   | |  / _ \  / _` | | '_ \  | '_ \  \ \ /\ / /  / _ \  / _` |    "
"   | |__| | |  __/ | (_| | | | | | | | | |  \ V  V /  |  __/ | (_| |    "
"    \____/   \___|  \__,_| |_| |_| |_| |_|   \_/\_/    \___|  \__,_|    "
"                                                                        "
"                                                                        "
" This vimrc.vim file is a personal vim configuration file.              "
" It's free for you to use and share                                     "
"                                                                        "
" author : Jinghui Hu                                                    "
" email  : hujinghui@buaa.edu.cn                                         "
" github : https://github.com/Jeanhwea/                                  "
"                                                                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" Defaults {{{1
set history=5000
set ruler
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set listchars=tab:▸\ ,eol:¬
set list
set modeline
"}}}
" FileType related settings {{{1
if has("autocmd")
    filetype on
    " set tabstop softtabstop shiftwidth expandtab
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css  setlocal ts=2 sts=2 sw=2 expandtab
    " set cindent autoindent
    autocmd FileType c    setlocal cindent autoindent
    autocmd FileType cpp  setlocal cindent autoindent
    autocmd FileType java setlocal cindent autoindent
    " set list chars
    autocmd FileType text setlocal listchars=tab:▸\ ,eol:☠
    autocmd FileType mkd  setlocal listchars=tab:▸\ ,eol:☠
    autocmd FileType vim  setlocal listchars=tab:▸\ ,eol:☠
    autocmd FileType java setlocal listchars=tab:▸\ ,trail:♀,eol:☠
    " set dictionary
    autocmd FileType java setlocal dict+=~/.vim/dict/java.dict
endif
"}}}
" Colorscheme {{{1
" set t_Co=256
" set if you prefer the scheme to match the original monokai background color
let g:molokai_original=1
let g:rehash256=1
colorscheme molokai
" notice that molokai colorscheme need 256 color support
" export TERM=xterm-256color, in your gnome-terminal
"}}}
" Functions {{{1
function! Preserve(command) " maintain the state and execute the command {{{2
    " Preparation, save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }}}
function! Stab() " set tabstop, softtabstop and shiftwidth to the same value {{{2
    let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
    if l:tabstop > 0
        let &l:sts = l:tabstop
        let &l:ts = l:tabstop
        let &l:sw = l:tabstop
    endif
    call SummarizeTabs()
endfunction
function! SummarizeTabs()
    try
        echohl ModeMsg
        echon 'tabstop='.&l:ts
        echon ' shiftwidth='.&l:sw
        echon ' softtabstop='.&l:sts
        if &l:et
            echon ' expandtab'
        else
            echon ' noexpandtab'
        endif
    finally
        echohl None
    endtry
endfunction
command! -nargs=* Stab call Stab()
" }}}
function! ToggleSearchOption() " set hlsearch incsearch {{{2
    set hlsearch!
    set incsearch!
endfunction
command! -nargs=* ToggleSearchOption call ToggleSearchOption()
" }}}
function! QuickfixFilenames() " add a quickfixdo just like `argdo` `bufdo` and `windo` {{{2
    " Building a hash ensures we get each buffer only once
    let buffer_numbers = {}
    for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
    endfor
    return join(values(buffer_numbers))
endfunction
" Using this, like following steps, see: https://github.com/nelstrom/vim-qargs
" :Ggrep findme
" :Qargs
" :argdo %s/findme/replacement/gc
" :argdo update
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
" }}}
"}}}
" Shortcuts {{{1
" Python command {{{2
:nmap <leader>py <ESC>:w<CR>:! python % <CR>
:nmap <leader>rpy <ESC>:w<CR>:r ! python % <CR>
" }}}
" Remove trails and blank lines {{{2
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("g/^\\s*$/d")<CR>
" }}}
" Insert date and time {{{2
imap <silent> <C-D><C-D> <C-R>=strftime("%e/%b/%Y")<CR>
imap <silent> <C-T><C-T> <C-R>=strftime("%l:%M:%p")<CR>
"}}}
" Toggle `set list` {{{2
nmap <leader>li :set list!<CR>
" }}}
" Toggle `set number` {{{2
nmap <leader>nu :set number!<CR>
" }}}
" Editing a new file in current directory {{{2
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
" }}}
"}}}
" Plugins settings {{{1
" pathogen {{{2
exec pathogen#infect()
" }}}
" repeat {{{2
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
" }}}
" gundo {{{2
" Toggle undo tree
nmap <leader>ud :GundoToggle<CR>
" }}}
" figitive {{{2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" }}}
" utilsnips {{{2
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
" javacomplete2 {{{2
if has("autocmd")
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
endif
" }}}
"}}}
