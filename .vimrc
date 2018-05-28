set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=utf-8
filetype plugin indent on    " required
syntax on

""""""""""""""Plugin""""""""""""""""
" Specify a directory for plugins
" " - For Neovim: ~/.local/share/nvim/plugged
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'Valloric/YouCompleteMe'
" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'jiangmiao/auto-pairs'

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'fatih/vim-go'

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" Initialize plugin system
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'
call plug#end()
Plug 'sillybun/vim-repl'
Plug 'tpope/vim-sensible'
"""""""""""""""""""YCM""""""""""""
let g:ycm_confirm_extra_conf = 0 "confirm loading .ycm_extra_conf.py at startup
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py' "fallback
let g:ycm_collect_identifiers_from_tags_files = 0
"let g:ycm_semantic_triggers =  {
"  \   'c' : ['->', '.'],
"  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
"  \             're!\[.*\]\s'],
"  \   'ocaml' : ['.', '#'],
"  \   'cpp,objcpp' : ['->', '.', '::'],
"  \   'perl' : ['->'],
"  \   'php' : ['->', '::'],
"  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
"  \   'ruby' : ['.', '::'],
"  \   'lua' : ['.', ':'],
"  \   'erlang' : [':'],
"  \ }
""""""""""""""""""""" vim-gutentags """"""""""""""""""""""""""""
" ctags
set tags=./tags;,tags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

"""""""""""""""""""asyncrun""""""""""""""""""
let g:asyncrun_open = 6
let g:asyncrun_bell = 1
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
""""""""""""""""""ale linting""""""""""""""
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

"""""""""""""""" YWZ's configuration """"""""""""""""""
nmap <C-N> :NERDTree<CR>
nmap <C-J> :bn<CR>
nmap <C-k> :bp<CR>
nmap <C-c> <ESC>
nmap <F2> :set hlsearch!<CR>
nmap <F3> :set paste!<CR>
nmap <F5> :set number!<CR>
imap <C-K> <C-Space>
nnoremap tn :tabnew
nnoremap tj :tabnext<CR>
nnoremap tk :tabnext<CR>
" nnoremap <C-L> <C-]>
nnoremap <C-]> :YcmCompleter GoTo<CR>
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
