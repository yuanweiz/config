set nocompatible              " be iMproved, required
set encoding=utf-8
filetype off                  " required
filetype plugin indent on    " required
syntax on
let mapleader="\<space>"
set number
set relativenumber

""""""""""""""Plugin""""""""""""""""
" Specify a directory for plugins
" " - For Neovim: ~/.local/share/nvim/plugged
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'w0rp/ale'
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'easymotion/vim-easymotion'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'SirVer/ultisnips'
Plug 'scrooloose/nerdtree'
Plug 'Townk/vim-autoclose'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ludovicchabant/vim-gutentags'

if filereadable( $HOME . "/extra_plugin.vim")
    exec 'source ' . $HOME . "/extra_plugin.vim"
endif
call plug#end()

set tags=./tags;,tags
let g:gutentags_enabled = 1
let g:gutentags_define_advanced_commands = 1
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_modules = []
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

""""""""""""""""""ale linting""""""""""""""
"let g:ale_linters_explicit = 1
"let g:ale_set_loclist=0
"let g:ale_set_quickfix=1
"let g:ale_echo_msg_format = '[%linter%] %code: %%s'
"let g:ale_lint_on_text_changed = 'always' " normal
"let g:ale_lint_on_insert_leave = 1
"let g:ale_linters = {'go': ['go build']} "TODO: 'go vet' doesn't work well
"let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
"let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
"let g:ale_c_cppcheck_options = ''
"let g:ale_cpp_cppcheck_options = ''

"""""""""""""""" key mappings """"""""""""""""""
colorscheme deus
hi Normal guibg=NONE ctermbg=NONE
nmap <silent> <C-N> :NERDTreeToggle<CR>
nmap <silent> <F2> :set hlsearch!<CR>
nmap <silent> <F3> :set paste!<CR>
nmap <silent> <F4> :set relativenumber!<CR>
nmap <silent> <F5> :redraw!<CR>

nmap <leader>1 1gt<CR>
nmap <leader>2 2gt<CR>
nmap <leader>3 3gt<CR>
nmap <leader>4 4gt<CR>
nmap <leader>5 5gt<CR>
nmap <leader>6 6gt<CR>
nmap <leader>7 7gt<CR>
nmap <leader>8 8gt<CR>
nmap <leader>9 9gt<CR>
nmap <silent> <leader>rp :RainbowParenthesesToggleAll<CR>
nmap <silent> <leader>cp :cprev<cr>
nmap <silent> <leader>cn :cnext<cr>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-h> :wincmd h<CR>

function! YankToTmux() range
    silent! normal gv"ny
    silent! call system('tmux set-buffer ' . shellescape(@n) )
endfunction
function! YankToClipBoard() range
    silent! normal gv"ny
    silent! call system("echo -n " . shellescape(@n) . " | nc localhost 9961")
endfunction

nnoremap <silent> <leader>yw :call system('tmux set-buffer ' . expand('<cword>'))<CR>
vnoremap <silent> <leader>y :call YankToTmux()<CR>
vnoremap <silent> <leader>Y :call YankToClipBoard()<CR>
nnoremap <silent> <leader>ln :call system('tmux set-buffer "'. expand('%:p').':'.line('.').'"')<CR>
nnoremap <silent> <leader>ll :call system('tmux set-buffer "'. expand('%:p').'"')<CR>
set mouse=

" au FileType go nnoremap <leader>gd :GoDecls<CR>
" au FileType ocaml nnoremap <leader>] :MerlinLocate<CR> 
" au FileType ocaml nnoremap <leader>t :MerlinTypeOf<CR>
" au FileType ocaml vnoremap <leader>t :MerlinTypeOfSel<CR>

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

""""""""""""""""" easymotion """""""""""""""
nmap <leader>m <Plug>(easymotion-prefix)
nmap <Plug>(easymotion-prefix)f <Plug>(easymotion-overwin-f)
nmap <Plug>(easymotion-prefix)m <Plug>(easymotion-overwin-f)
nmap <Plug>(easymotion-prefix)j <Plug>(easymotion-overwin-line)
nmap <Plug>(easymotion-prefix)w <Plug>(easymotion-overwin-w)

nmap <leader>j <Plug>(easymotion-overwin-line)
nmap <leader>s <Plug>(easymotion-overwin-f)
nmap <leader>w <Plug>(easymotion-overwin-w)

""""""""""""""""" UltiSnips """"""""""""""""""
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger = 'qq'

"""""""""""""""""""""" fzf """""""""""""""""""""""
let g:fzf_command_prefix = 'Fzf'

function! s:get_git_root()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  return v:shell_error ? '' : root
endfunction

function! FZF_cd()
  let root = s:get_git_root()
  if empty(root)
    return s:warn('Not in git repo')
  endif
    return fzf#run({
    \ 'source':  'git ls-files --exclude-standard | xargs dirname | sort | uniq',
    \ 'dir':     root,
    \ 'sink':    'cd',
    \})
endfunction
nmap <silent> <leader>ff :FZF<CR>
nmap <silent> <leader>fp :FzfGFiles --exclude-standard<CR>
nmap <silent> <leader>fg :FzfRg<space>
nmap <silent> <leader>fb :FzfBuffers<CR>
nmap <silent> <leader>fc :FzfCommands<CR>
nmap <silent> <leader>fd :call FZF_cd()<CR>

""""""""""""""""""""" lsp """"""""""""""""""""""""
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'go': ['gopls'],
    \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
    \ }
nnoremap <silent> <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>lg :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>] :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>lr :call LanguageClient#textDocument_rename()<CR>

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

autocmd BufWritePre *.go,*.c,*.cpp :call LanguageClient#textDocument_formatting_sync()

if filereadable("~/extra_config.vim")
    source "~/extra_config.vim"
endif

