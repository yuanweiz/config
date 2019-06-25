set nocompatible              " be iMproved, required
set encoding=utf-8
filetype off                  " required
filetype plugin indent on    " required
syntax on
let mapleader="\<space>"

""""""""""""""Plugin""""""""""""""""
" Specify a directory for plugins
" " - For Neovim: ~/.local/share/nvim/plugged
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'w0rp/ale'
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'kien/rainbow_parentheses.vim'
" Plug 'fatih/vim-go'
" Plug 'guns/vim-sexp',    {'for': 'clojure'}
" Plug 'liquidz/vim-iced', {'for': 'clojure'}

call plug#end()
"""""""""""""""""""YCM""""""""""""
let g:ycm_confirm_extra_conf = 0 "confirm loading .ycm_extra_conf.py at startup
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py' "fallback
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_key_invoke_completion = '<c-z>'
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }
""""""""""""""""""""" vim-gutentags """"""""""""""""""""""""""""
" ctags

let g:gutentags_enabled = 0
let g:gutentags_define_advanced_commands = 1
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/usr/share/gtags/gtags.conf' " expand('~/.globalrc')
set tags=./tags;,tags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_modules = []
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif
let g:gutentags_auto_add_gtags_cscope = 0

""""""""""""""""""ale linting""""""""""""""
let g:ale_linters_explicit = 1
let g:ale_set_loclist=0
let g:ale_set_quickfix=1
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'always' " normal
let g:ale_lint_on_insert_leave = 1
"
let g:ale_linters = {'go': ['go build']} "TODO: 'go vet' doesn't work well
"let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
"let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
"let g:ale_c_cppcheck_options = ''
"let g:ale_cpp_cppcheck_options = ''

"""""""""""""""" key mappings """"""""""""""""""
colorscheme torte
hi Normal guibg=NONE ctermbg=NONE
nmap <C-N> :NERDTree<CR>
nmap <F2> :set hlsearch!<CR>
nmap <F3> :set paste!<CR>
nmap <F4> :set number!<CR>
nmap <F5> :redraw!<CR>

" moving cursor without exiting insert mode
inoremap <C-J> <Down>
inoremap <C-H> <Left>
inoremap <C-K> <Up>
inoremap <C-L> <Right>
inoremap <C-B> <C-O>b
inoremap <C-E> <C-O>e

nnoremap <leader>f :FZF<CR>
nnoremap <leader>1 1gt<CR>
nnoremap <leader>2 2gt<CR>
nnoremap <leader>3 3gt<CR>
nnoremap <leader>4 4gt<CR>
nnoremap <leader>5 5gt<CR>
nnoremap <leader>6 6gt<CR>
nnoremap <leader>7 7gt<CR>
nnoremap <leader>8 8gt<CR>
nnoremap <leader>9 9gt<CR>
nnoremap <leader>rp :RainbowParenthesesToggleAll<CR>
nnoremap <leader>cp :cprev<cr>
nnoremap <leader>cn :cnext<cr>

nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>
nnoremap <C-h> :wincmd h<CR>

function! YankToTmux() range
    silent! normal gv"ny
    silent! call system('tmux set-buffer ' . shellescape(@n) )
endfunction
nnoremap <silent> <leader>yw :call system('tmux set-buffer ' . expand('<cword>'))<CR>
vnoremap <silent> <leader>y :call YankToTmux()<CR>
nnoremap <silent> <leader>ln :call system('tmux set-buffer "'. expand('%:p').':'.line('.').'"')<CR>
nnoremap <silent> <leader>ll :call system('tmux set-buffer "'. expand('%:p').'"')<CR>
set mouse=

au FileType go nnoremap <leader>gd :GoDecls<CR>
au FileType go nnoremap <leader>] :YcmCompleter GoTo<CR>
au FileType cpp nnoremap <leader>] :YcmCompleter GoTo<CR>
au FileType ocaml nnoremap <leader>] :MerlinLocate<CR> 
au FileType ocaml nnoremap <leader>t :MerlinTypeOf<CR>
au FileType ocaml vnoremap <leader>t :MerlinTypeOfSel<CR>

set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

""""""""""""""""" vim-preview """"""""""""""""""""""""""
autocmd FileType qf nnoremap <silent><buffer> o :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> c :PreviewClose<cr>
autocmd FileType qf nnoremap <silent><buffer> J :PreviewScroll +1<cr>
autocmd FileType qf nnoremap <silent><buffer> K :PreviewScroll -1<cr>

""""""""""""""""""rainbow parentheses""""""""""""""
let g:rbpt_loadcmd_toggle = 1
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

if filereadable( $HOME . "/.vimrc.extra")
    execute 'source '. $HOME . '/.vimrc.extra'
endif
