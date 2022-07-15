function! s:Find_glob(pattern, path)
    let fullpattern = a:path . "/" . a:pattern
    if strlen(glob(fullpattern))
        return 1
    else
        let parts = split(a:path, "/")
        if len(parts)
            let newpath = "/" . join(parts[0:-2], "/")
            return s:Find_glob(a:pattern, newpath)
        else
            return 0
        endif
    endif
endfunction

function! s:Find_cabal()
    if(s:Find_glob("*.cabal", "."))
        return " --stdin-input-file " . @%
    else
        return " --no-cabal "
    endif
endfunction

function! vim_fourmolu#FourmoluWriteOn()
    let g:fourmolu_write = 1
endfunction

function! vim_fourmolu#FourmoluWriteOff()
    let g:fourmolu_write = 0 
endfunction

function! vim_fourmolu#FourmoluWriteToggle()
    let g:fourmolu_write = !g:fourmolu_write
endfunction

function! vim_fourmolu#FourmoluFmt() range
    if !executable(g:fourmolu_executable)
        echoerr "Couldn't run " . g:fourmolu_executable
    else

    silent exe "keepjumps " . a:firstline . "," . a:lastline
        \ . "!" . g:fourmolu_executable
        \ . s:Find_cabal()

    call winrestview(b:winview)
    endif
endfunction

function! vim_fourmolu#FourmoluWriteRun()
    if g:fourmolu_write
        let b:winview = winsaveview()
        exe "%call vim_fourmolu#FourmoluFmt()"
    endif
endfunction
