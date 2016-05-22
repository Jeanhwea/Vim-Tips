" vim:set foldmethod=marker:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" {{{1
"         _                          _                                  "
"        | |                        | |                                 "
"        | |   ___    __ _   _ __   | |__   __      __   ___    __ _    "
"    _   | |  / _ \  / _` | | '_ \  | '_ \  \ \ /\ / /  / _ \  / _` |   "
"   | |__| | |  __/ | (_| | | | | | | | | |  \ V  V /  |  __/ | (_| |   "
"    \____/   \___|  \__,_| |_| |_| |_| |_|   \_/\_/    \___|  \__,_|   "
"                                                                       "
"                                                                       "
" This vimrc.vim file is a personal vim configuration file.             "
" It's free for you to use and share                                    "
"                                                                       "
" author : Jinghui Hu                                                   "
" email  : hujinghui@buaa.edu.cn                                        "
" github : https://github.com/Jeanhwea/                                 "
"                                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" Defaults {{{1
set history=1000
set dictionary+=/usr/share/dict/words
set backspace=indent,eol,start
set list
set listchars=tab:▸\ ,trail:∙,eol:¬
set modeline
set ruler
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set commentstring=\/\/\ %s
set grepprg=grep\ -rnh\ --exclude='.*.swp'\ --exclude='*~'\ --exclude=tags
set virtualedit=block
set wildmode=list:longest,full
set wildignore+=*.o,*.obj,*~,*.class
set wildignore+=*.png,*.jpg,*.gif,*.xpm,*.tiff
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamedplus
endif
"}}}
" FileType related settings {{{1
if has("autocmd")
    filetype plugin indent on
    augroup FTOptions " {{{2
        autocmd!
        " set tabstop softtabstop shiftwidth expandtab/noexpandtab
        autocmd FileType javascript,html,css setlocal ts=2 sts=2 sw=2 et
        autocmd FileType make setlocal ts=8 sts=8 sw=8 noet
        autocmd FileType text,mkd setlocal ts=4 sts=4 sw=4 noet
        " set cindent autoindent
        autocmd FileType c,cpp,java setlocal cin ai
        autocmd FileType python,vim,javascript,html,css setlocal nocin ai
        autocmd FileType text,mkd setlocal nocin noai
        " set list
        autocmd FileType text,mkd setlocal nolist
        " set commentstring
        autocmd FileType c,cpp,java setlocal cms=\/\/\ %s
        autocmd FileType python setlocal cms=\#\ %s
        autocmd FileType vim setlocal cms=\"\ %s
        autocmd FileType viz setlocal cms=\'\ %s
    augroup END
    " }}}
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
function! SwapTabAndSpace() " {{{2
    if &expandtab 
        set noexpandtab
        :%retab!
    else
        set expandtab
        :%retab!
    endif
endfunction
command! -nargs=* SwapTabAndSpace call SwapTabAndSpace()<CR>
" }}}
function! GenCtags(type) " generate tags files {{{
    if a:type ==# 'cpp'
    endif
endfunction
" }}}
function! ToggleSearchOption() " set hlsearch incsearch {{{2
    set hlsearch!
    set incsearch!
endfunction
noremap <LocalLeader>ts :call ToggleSearchOption()<CR>
" }}}
function! ToggleNumberOption() " set hlsearch incsearch {{{2
    if &relativenumber
        set nonumber
        set norelativenumber
    else
        set number
        set relativenumber
    endif
endfunction
noremap <LocalLeader>tn :call ToggleNumberOption()<CR>
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
function! WinMove(key) "move to the window in the direction shown, or create a new window {{{2
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction
" Window movement shortcuts
" nnoremap <C-h> :call WinMove('h')<cr>
" nnoremap <C-l> :call WinMove('l')<cr>
" nnoremap <C-j> :call WinMove('j')<cr>
" nnoremap <C-k> :call WinMove('k')<cr>
" }}}
function! s:GrepOperator(type) " grep words in current directory {{{2
    let saved_unnamed_register = @@
    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif
    silent execute "grep! -R " . shellescape(@@) . " ."
    copen
    let @@ = saved_unnamed_register
endfunction
nnoremap <LocalLeader>f :set operatorfunc=<SID>GrepOperator<CR>g@
vnoremap <LocalLeader>f :<C-u>call <SID>GrepOperator(visualmode())<CR>
" }}}
"}}}
" Shortcuts {{{1
" Remove trails and blank lines {{{2
nnoremap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nnoremap _= :call Preserve("g/^\\s*$/d")<CR>
" }}}
" Insert date and time {{{2
inoremap <silent> <C-d><C-d> <C-r>=strftime("%e/%b/%Y")<CR>
inoremap <silent> <C-t><C-t> <C-r>=strftime("%l:%M:%p")<CR>
"}}}
" Editing a new file in current directory {{{2
noremap <LocalLeader>ew :e <C-r>=expand("%:p:h") . "/" <CR>
noremap <LocalLeader>es :sp <C-r>=expand("%:p:h") . "/" <CR>
noremap <LocalLeader>ev :vsp <C-r>=expand("%:p:h") . "/" <CR>
noremap <LocalLeader>et :tabe <C-r>=expand("%:p:h") . "/" <CR>
" }}}
" Digraph {{{2
nnoremap <LocalLeader>di :digraphs<CR>
" }}}
"}}}
" Plugins {{{1
" pathogen {{{2
exec pathogen#infect()
" }}}
" repeat {{{2
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
" }}}
" gundo {{{2
" Toggle undo tree
nnoremap <LocalLeader>tu :GundoToggle<CR>
" }}}
" tagbar {{{2
nnoremap <LocalLeader>tt :TagbarToggle<CR>
" }}}
" tabular {{{2
nnoremap <LocalLeader>= :Tabularize /
vnoremap <LocalLeader>= :Tabularize /
"  }}}
" figitive {{{2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
nnoremap <LocalLeader>gb :Gblame<CR>
nnoremap <LocalLeader>gc :Gcommit<CR>
nnoremap <LocalLeader>gd :Gdiff<CR>
nnoremap <LocalLeader>gl :Glog<CR>
nnoremap <LocalLeader>gp :Gpush<CR>
nnoremap <LocalLeader>gr :Gread<CR>
nnoremap <LocalLeader>gs :Gstatus<CR>
nnoremap <LocalLeader>gw :Gwrite<CR>
" }}}
" utilsnips {{{2
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
" javacomplete2 {{{2
if has("autocmd")
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
endif
" smart imports
nnoremap <F4> <Plug>(JavaComplete-Imports-AddSmart)
inoremap <F4> <Plug>(JavaComplete-Imports-AddSmart)
nnoremap <F5> <Plug>(JavaComplete-Imports-Add)
inoremap <F5> <Plug>(JavaComplete-Imports-Add)
nnoremap <F6> <Plug>(JavaComplete-Imports-AddMissing)
inoremap <F6> <Plug>(JavaComplete-Imports-AddMissing)
nnoremap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
inoremap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
" getters and setters
" nnoremap <buffer> <LocalLeader>jA <Plug>(JavaComplete-Generate-Accessors)
" nnoremap <buffer> <LocalLeader>js <Plug>(JavaComplete-Generate-AccessorSetter)
" nnoremap <buffer> <LocalLeader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
" nnoremap <buffer> <LocalLeader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
" inoremap <buffer> <C-j>s <Plug>(JavaComplete-Generate-AccessorSetter)
" inoremap <buffer> <C-j>g <Plug>(JavaComplete-Generate-AccessorGetter)
" inoremap <buffer> <C-j>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)
" }}}
" vim-markdown {{{2
let g:markdown_fenced_languages = ['java', 'html', 'javascript', 'css', 'cpp', 'vim', 'bash=sh']
" }}}
" nerdtree {{{2
nnoremap <LocalLeader>te :NERDTreeToggle<CR>
" }}}
" ctrlp {{{2
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
" set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': '',
  \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" }}}
" syntastic {{{2
" help syntastic to see more
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": ["ruby", "php", "python"],
    \ "passive_filetypes": [] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
nnoremap <LocalLeader>st :SyntasticToggleMode<CR>
nnoremap <LocalLeader>sc :SyntasticCheck<CR>
nnoremap <LocalLeader>sr :SyntasticReset<CR>
" }}}
" neocomplete {{{2
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default'    : '',
    \ 'bash'       : $HOME.'/.bash_history',
    \ 'vimshell'   : $HOME.'/.viminfo',
    \ 'c'          : $HOME.'/.dict/c.dict',
    \ 'cpp'        : $HOME.'/.dict/c.dict',
    \ 'cs'         : $HOME.'/.dict/cs.dict',
    \ 'css'        : $HOME.'/.dict/css.dict',
    \ 'html'       : $HOME.'/.dict/html.dict',
    \ 'java'       : $HOME.'/.dict/java.dict',
    \ 'javascript' : $HOME.'/.dict/javascript.dict',
    \ 'node'       : $HOME.'/.dict/node.dict',
    \ 'php'        : $HOME.'/.dict/php.dict',
    \ 'python'     : $HOME.'/.dict/python.dict',
    \ 'ruby'       : $HOME.'/.dict/ruby.dict',
    \ 'tex'        : $HOME.'/.dict/tex.dict',
    \ 'vim'        : $HOME.'/.dict/vim.dict',
    \ 'viz'        : $HOME.'/.dict/viz.dict',
\ }
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1
" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
" Enable omni completion.
if has("autocmd")
    autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType markdown   setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
endif
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}}
" signify {{{2
let g:signify_disable_by_default = 1
let g:signify_vcs_list = [ 'git' , 'hg' ]
nnoremap <LocalLeader>tc :SignifyToggle<CR>
" }}}
" rainbow {{{2
let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}
nnoremap <LocalLeader>tr :RainbowToggle<CR>
" }}}
"}}}
