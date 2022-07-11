augroup vim_fourmolu
    autocmd!
    autocmd BufWritePre *.hs call vim_fourmolu#FourmoluWriteRun()
augroup END
