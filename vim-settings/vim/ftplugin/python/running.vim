if !exists("g:python_command")
    let g:python_command = 'python'
endif

function! PythonCompileAndRunFile()
    silent !clear
    execute '!' . g:python_command . ' ' . bufname('%')
endfunction

nnoremap <buffer> <leader>r :call PythonCompileAndRunFile()<CR>

