" vim:set foldmethod=marker:
" maintain the state and execute the command {{{1
function! Preserve(command)
    " Preparation, save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction " }}} 

" set tabstop, softtabstop and shiftwidth to the same value {{{1
command! -nargs=* Stab call Stab()
function! Stab()
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
endfunction " }}}

" set hlsearch incsearch {{{1
command! -nargs=* SsearchOption call SsearchOption()
function! SsearchOption()
    set hlsearch!
    set incsearch!
endfunction " }}}

" add a quickfixdo just like `argdo` `bufdo` and `windo` {{{1
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
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
" :argdo update }}}


