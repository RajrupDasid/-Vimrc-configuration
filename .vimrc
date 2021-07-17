" Set options if using spaces for indents (default).
function PySpacesCfg()
  set expandtab
  set tabstop=8
  set softtabstop=4
  set shiftwidth=4
endfunction

" Set options if using tabs for indents.
function PyTabsCfg()
  set noexpandtab
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
endfunction

" Return 1 if using tabs for indents, or 0 otherwise.
function PyIsTabIndent()
  let lnum = 1
  let got_cols = 0  " 1 if previous lines ended with columns
  while lnum <= 100
    let line = getline(lnum)
    let lnum = lnum + 1
    if got_cols == 1
      if line =~ "^\t\t"  " two tabs to prevent false positives
        return 1
      endif
    endif
    if line =~ ":\s*$"
      let got_cols = 1
    else
      let got_cols = 0
    endif
  endwhile
  return 0
endfunction

" Check current buffer and configure for tab or space indents.
function PyIndentAutoCfg()
  if PyIsTabIndent()
    call PyTabsCfg()
  else
    call PySpacesCfg()
  endif
endfunction
function! PyIsTabIndent()
  let lnum = 1
  while lnum <= 100
    let line = getline(lnum)
    let lnum = lnum + 1
    if line =~ '^\t\t\(if\|while\|do\|for\|public\|private\|char\|int\|float\|double\|call\)\>'
      return 1
    endif
  endwhile
  return 0
endfunction
"python ends here
"golang config starts here
function! s:ExecuteInShell(command, bang)
    let _ = a:bang != '' ? s:_ : a:command == '' ? '' : join(map(split(a:command), 'expand(v:val)'))

    if (_ != '')
        let s:_ = _
        let bufnr = bufnr('%')
        let winnr = bufwinnr('^' . _ . '$')
        silent! execute  winnr < 0 ? 'belowright new ' . fnameescape(_) : winnr . 'wincmd w'
        setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile wrap number
        silent! :%d
        let message = 'Execute ' . _ . '...'
        call append(0, message)
        echo message
        silent! 2d | resize 1 | redraw
        silent! execute 'silent! %!'. _
        silent! execute 'resize ' . line('$')
        silent! execute 'syntax on'
        silent! execute 'autocmd BufUnload <buffer> execute bufwinnr(' . bufnr . ') . ''wincmd w'''
        silent! execute 'autocmd BufEnter <buffer> execute ''resize '' .  line(''$'')'
        silent! execute 'nnoremap <silent> <buffer> <CR> :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
        silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
        silent! execute 'nnoremap <silent> <buffer> <LocalLeader>g :execute bufwinnr(' . bufnr . ') . ''wincmd w''<CR>'
        nnoremap <silent> <buffer> <C-W>_ :execute 'resize ' . line('$')<CR>
        silent! syntax on
    endif
endfunction
"golang config ends here
"additional config for golang
command! -complete=shellcmd -nargs=* -bang Shell call s:ExecuteInShell(<q-args>, '<bang>')
cabbrev shell Shell

" my additional tools
command! -complete=shellcmd -nargs=* -bang Gor call s:ExecuteInShell('go run %', '<bang>')
command! -complete=shellcmd -nargs=* -bang Gon call s:ExecuteInShell('go install', '<bang>')
command! -complete=shellcmd -nargs=* -bang Gob call s:ExecuteInShell('go build', '<bang>')
command! -complete=shellcmd -nargs=* -bang Got call s:ExecuteInShell('go test -v', '<bang>')

:map <F5>  :Gor<CR>
:map <F6>  :Gob<CR>
:map <F7>  :Gon<CR>
:map <F9>  :Got<CR>
:map <F10> :Fmt<CR>:w<CR>
:map <F12> :q<CR>
cabbrev fmt Fmt
:set fileencodings=utf-8
"go syntax highliting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
"auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
" Status line types/signatures
let g:go_auto_type_info =1 
"vim config strats here
colorscheme slate 
syntax on
filetype plugin on
filetype plugin indent on
set autowrite
set nu
set autoindent
set tabstop=8
set softtabstop=4
set splitbelow
set splitright
set shiftwidth=4
set textwidth=180
set expandtab
set fileformat=unix
set undodir=/tmp
set undofile
set wildmode=full
set virtualedit=block
set encoding=utf-8
set backspace=indent,eol,start
"forgolang configure
call plug#begin('~/.vim/plugged')
Plug 'cakebaker/scss-syntax.vim'
Plug 'chr4/nginx.vim'
Plug 'chrisbra/csv.vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'godlygeek/tabular' | Plug 'tpope/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'jvirtanen/vim-hcl'
Plug 'lifepillar/pgsql.vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'stephpy/vim-yaml'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-git'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-rails'
Plug 'vim-python/python-syntax'
Plug 'vim-ruby/vim-ruby'
Plug 'wgwoods/vim-systemd-syntax'
Plug 'tpope/vim-eunuch'
Plug 'unblevable/quick-scope'
Plug 'vim-scripts/AutoComplPop'
Plug 'preservim/nerdtree'
Plug 'frazrepo/vim-rainbow'
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'
Plug 'google/vim-codefmt'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-syntastic/syntastic'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()
