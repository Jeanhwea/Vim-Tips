"=============================================================================
" FILE: handler.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! neocomplete#handler#_on_moved_i() "{{{
  let neocomplete = neocomplete#get_current_neocomplete()
  if neocomplete.linenr != line('.')
    call neocomplete#helper#clear_result()
  endif
  let neocomplete.linenr = line('.')

  call s:close_preview_window()
endfunction"}}}
function! neocomplete#handler#_on_insert_enter() "{{{
  if !neocomplete#is_enabled()
    return
  endif

  let neocomplete = neocomplete#get_current_neocomplete()
  if neocomplete.linenr != line('.')
    call neocomplete#helper#clear_result()
  endif
  let neocomplete.linenr = line('.')

  if &l:foldmethod ==# 'expr' && foldlevel('.') != 0
    foldopen
  endif
endfunction"}}}
function! neocomplete#handler#_on_insert_leave() "{{{
  call neocomplete#helper#clear_result()

  call s:close_preview_window()
  call s:make_cache_current_line()

  let neocomplete = neocomplete#get_current_neocomplete()
  let neocomplete.cur_text = ''
  let neocomplete.completed_item = {}
  let neocomplete.overlapped_items = {}
endfunction"}}}
function! neocomplete#handler#_on_write_post() "{{{
  " Restore foldinfo.
  for winnr in filter(range(1, winnr('$')),
        \ "!empty(getwinvar(v:val, 'neocomplete_foldinfo'))")
    let neocomplete_foldinfo =
          \ getwinvar(winnr, 'neocomplete_foldinfo')
    call setwinvar(winnr, '&foldmethod',
          \ neocomplete_foldinfo.foldmethod)
    call setwinvar(winnr, '&foldexpr',
          \ neocomplete_foldinfo.foldexpr)
    call setwinvar(winnr,
          \ 'neocomplete_foldinfo', {})
  endfor
endfunction"}}}
" @vimlint(EVL102, 1, v:completed_item)
function! neocomplete#handler#_on_complete_done() "{{{
  let neocomplete = neocomplete#get_current_neocomplete()

  " Get cursor word.
  if exists('v:completed_item')
    " Use v:completed_item feature.
    if empty(v:completed_item)
      return
    endif

    let complete_str = v:completed_item.word
    if complete_str == ''
      return
    endif

    if (v:completed_item.abbr != ''
          \ && len(v:completed_item.word) < len(v:completed_item.abbr))
          \ || v:completed_item.info != ''
      let neocomplete.completed_item = v:completed_item
    endif
  else
    let cur_text = matchstr(getline('.'), '^.*\%'.col('.').'c')
    let complete_str = neocomplete#helper#match_word(cur_text)[1]
    if complete_str == ''
      " Use default keyword pattern.
      let complete_str = matchstr(cur_text, '\h\w*\(()\?\)\?$')
      if complete_str == ''
        return
      endif
    endif

    let candidates = filter(copy(neocomplete.candidates),
          \   "v:val.word ==# complete_str &&
          \    ((get(v:val, 'abbr', '') != '' &&
          \     v:val.word !=# v:val.abbr && v:val.abbr[-1] != '~') ||
          \     get(v:val, 'info', '') != '')")
    if !empty(candidates)
      let neocomplete.completed_item = candidates[0]
    endif
  endif

  " Restore overlapped item
  if exists('v:completed_item') &&
        \ has_key(neocomplete.overlapped_items, complete_str)
    " Move cursor
    call cursor(0, col('.') - len(complete_str) +
          \ len(neocomplete.overlapped_items[complete_str]))

    let complete_str = neocomplete.overlapped_items[complete_str]
  endif

  let frequencies = neocomplete#variables#get_frequencies()
  if !has_key(frequencies, complete_str)
    let frequencies[complete_str] = 20
  else
    let frequencies[complete_str] += 20
  endif
endfunction"}}}
" @vimlint(EVL102, 0, v:completed_item)
function! neocomplete#handler#_change_update_time() "{{{
  if &updatetime > g:neocomplete#cursor_hold_i_time
    " Change updatetime.
    let neocomplete = neocomplete#get_current_neocomplete()
    let neocomplete.update_time_save = &updatetime
    let &updatetime = g:neocomplete#cursor_hold_i_time
  endif
endfunction"}}}
function! neocomplete#handler#_restore_update_time() "{{{
  let neocomplete = neocomplete#get_current_neocomplete()
  if &updatetime < neocomplete.update_time_save
    " Restore updatetime.
    let &updatetime = neocomplete.update_time_save
  endif
endfunction"}}}
function! neocomplete#handler#_on_insert_char_pre() "{{{
  if neocomplete#is_cache_disabled()
    return
  endif

  let neocomplete = neocomplete#get_current_neocomplete()
  if neocomplete.old_char != ' ' && v:char == ' ' && v:count == 0
    call s:make_cache_current_line()
  endif

  let neocomplete.old_char = v:char
endfunction"}}}
function! neocomplete#handler#_on_text_changed() "{{{
  if neocomplete#is_cache_disabled()
    return
  endif

  let neocomplete = neocomplete#get_current_neocomplete()

  if g:neocomplete#enable_insert_char_pre
        \ && neocomplete.skip_next_complete
    call neocomplete#handler#_do_auto_complete('InsertCharPre')
  endif

  if getline('.') == ''
    call s:make_cache_current_line()
  endif

  " indent line matched by indentkeys
  let cur_text = matchstr(getline('.'), '^.*\%'.col('.').'c')
  if neocomplete.indent_text != matchstr(getline('.'), '\S.*$')
    for word in filter(map(split(&l:indentkeys, ','),
        \ "v:val =~ '^<.*>$' ? matchstr(v:val, '^<\\zs.*\\ze>$')
        \                  : matchstr(v:val, '.*=\\zs.*')"),
        \ "v:val != ''")
      if stridx(cur_text, word, len(cur_text)-len(word)-1) >= 0
        call neocomplete#helper#indent_current_line()
        let neocomplete.indent_text = matchstr(getline('.'), '\S.*$')
        break
      endif
    endfor
  endif
endfunction"}}}

function! neocomplete#handler#_do_auto_complete(event) "{{{
  if s:check_in_do_auto_complete()
    return
  endif

  let neocomplete = neocomplete#get_current_neocomplete()
  let neocomplete.skipped = 0
  let neocomplete.event = a:event

  let cur_text = neocomplete#get_cur_text(1)
  let complete_pos = -1

  call neocomplete#print_debug('cur_text = ' . cur_text)

  try
    " Prevent infinity loop.
    if s:is_skip_auto_complete(cur_text)
      call neocomplete#print_debug('Skipped.')
      return
    endif

    let complete_pos = s:check_force_omni(cur_text)
    if complete_pos >= 0
      return
    endif

    " Check multibyte input or eskk or spaces.
    if cur_text =~ '^\s*$'
          \ || neocomplete#is_eskk_enabled()
          \ || neocomplete#is_multibyte_input(cur_text)
      call neocomplete#print_debug('Skipped.')
      return
    endif

    try
      let neocomplete.is_auto_complete = 1

      " Do prefetch.
      let neocomplete.complete_sources =
            \ neocomplete#complete#_get_results(cur_text)
    finally
      let neocomplete.is_auto_complete = 0
    endtry

    if empty(neocomplete.complete_sources)
      let complete_pos = s:check_fallback(cur_text)
      return
    endif

    let complete_pos =
          \ neocomplete#complete#_get_complete_pos(
          \ neocomplete.complete_sources)
    let base = cur_text[complete_pos :]

    let neocomplete.candidates = neocomplete#complete#_get_words(
          \ neocomplete.complete_sources, complete_pos, base)
    if empty(neocomplete.candidates)
      return
    endif

    " Start auto complete.
    call s:complete_key(
          \ "\<Plug>(neocomplete_start_auto_complete)")
  finally
    call neocomplete#complete#_set_previous_position(cur_text, complete_pos)
  endtry
endfunction"}}}

function! s:check_in_do_auto_complete() "{{{
  if neocomplete#is_locked()
    return 1
  endif

  " Detect completefunc.
  if &l:completefunc != '' && &l:buftype =~ 'nofile'
    return 1
  endif
endfunction"}}}
function! s:is_skip_auto_complete(cur_text) "{{{
  let neocomplete = neocomplete#get_current_neocomplete()

  if (g:neocomplete#lock_iminsert && &l:iminsert)
        \ || (&l:formatoptions =~# '[tca]' && &l:textwidth > 0
        \     && strwidth(a:cur_text) >= &l:textwidth)
    let neocomplete.skip_next_complete = 0
    return 1
  endif

  let skip = neocomplete.skip_next_complete

  if !skip
    return 0
  endif

  " Check delimiter pattern.
  let is_delimiter = 0
  let filetype = neocomplete#get_context_filetype()

  for delimiter in ['/', '.'] +
        \ get(g:neocomplete#delimiter_patterns, filetype, [])
    if stridx(a:cur_text, delimiter,
          \ len(a:cur_text) - len(delimiter)) >= 0
      let is_delimiter = 1
      break
    endif
  endfor

  let neocomplete.skip_next_complete = 0
  return !(is_delimiter && skip == 2)
endfunction"}}}
function! s:close_preview_window() "{{{
  if g:neocomplete#enable_auto_close_preview
        \ && bufname('%') !=# '[Command Line]'
        \ && winnr('$') != 1 && !&l:previewwindow
        \ && !neocomplete#is_cache_disabled()
    " Close preview window.
    pclose!
  endif
endfunction"}}}
function! s:make_cache_current_line() "{{{
  let neocomplete = neocomplete#get_current_neocomplete()
  if neocomplete#helper#is_enabled_source('buffer',
        \ neocomplete.context_filetype)
    " Caching current cache line.
    call neocomplete#sources#buffer#make_cache_current_line()
  endif
  if neocomplete#helper#is_enabled_source('member',
        \ neocomplete.context_filetype)
    " Caching current cache line.
    call neocomplete#sources#member#make_cache_current_line()
  endif
endfunction"}}}
function! s:check_force_omni(cur_text) "{{{
  let cur_text = a:cur_text
  let complete_pos = neocomplete#helper#get_force_omni_complete_pos(cur_text)

  if complete_pos >= 0
        \ && !neocomplete#complete#_check_previous_position(
        \       cur_text, complete_pos)
    call s:complete_key("\<Plug>(neocomplete_start_omni_complete)")
  endif

  return complete_pos
endfunction"}}}
function! s:check_fallback(cur_text) "{{{
  let cur_text = a:cur_text
  let complete_pos = match(cur_text, '\h\w*$')
  let neocomplete = neocomplete#get_current_neocomplete()
  if !empty(g:neocomplete#fallback_mappings)
        \ && len(matchstr(cur_text, '\h\w*$'))
        \   >= g:neocomplete#auto_completion_start_length
        \ && !neocomplete.skip_next_complete
        \ && !neocomplete#complete#_check_previous_position(
        \      cur_text, complete_pos)
    let key = ''
    for i in range(0, len(g:neocomplete#fallback_mappings)-1)
      let key .= '<C-r>=neocomplete#mappings#fallback(' . i . ')<CR>'
    endfor
    execute 'inoremap <silent> <Plug>(neocomplete_fallback)' key

    " Fallback
    call s:complete_key("\<Plug>(neocomplete_fallback)")

    return complete_pos
  endif

  return -1
endfunction"}}}

function! s:complete_key(key) "{{{
  call neocomplete#helper#complete_configure()

  call feedkeys(a:key)
endfunction"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
