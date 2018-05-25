set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=utf-8
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
 " alternatively, pass a path where Vundle should install plugins
 "call vundle#begin('~/some/path/here')
 
 " let Vundle manage Vundle, required
 Plugin 'VundleVim/Vundle.vim'
 Plugin 'Valloric/YouCompleteMe'
 Plugin 'rdnetto/YCM-Generator'
 Plugin 'tikhomirov/vim-glsl'
 Plugin 'Harenome/vim-mipssyntax'
 Plugin 'scrooloose/nerdtree'
 
 " The following are examples of different formats supported.
 " Keep Plugin commands between vundle#begin/end.
 " plugin on GitHub repo
 " Plugin 'tpope/vim-fugitive'
 " plugin from http://vim-scripts.org/vim/scripts.html
 " Plugin 'L9'
 " Git plugin not hosted on GitHub
 " Plugin 'git://git.wincent.com/command-t.git'
 " git repos on your local machine (i.e. when working on your own plugin)
 " Plugin 'file:///home/gmarik/path/to/plugin'
 " The sparkup vim script is in a subdirectory of this repo called vim.
 " Pass the path to set the runtimepath properly.
 " Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
 " Install L9 and avoid a Naming conflict if you've already installed a
 " different version somewhere else.
 " Plugin 'ascenator/L9', {'name': 'newL9'}
 
 " All of your Plugins must be added before the following line
 call vundle#end()            " required
 filetype plugin indent on    " required
 " To ignore plugin indent changes, instead use:
 "filetype plugin on
 "
 " Brief help
 " :PluginList       - lists configured plugins
 " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
 " :PluginSearch foo - searches for foo; append `!` to refresh local cache
 " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
 "
 " see :h vundle for more details or wiki for FAQ
 " Put your non-Plugin stuff after this line
 "
 "
 syntax on
 
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
 " ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
 set rtp+=~/.opam/system/share/merlin/vim
 let s:opam_share_dir = system("opam config var share")
 let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')
 
 let s:opam_configuration = {}
 
 function! OpamConfOcpIndent()
   execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
 endfunction
 let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')
 
 function! OpamConfOcpIndex()
   execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
 endfunction
 let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')
 
 function! OpamConfMerlin()
   let l:dir = s:opam_share_dir . "/merlin/vim"
   execute "set rtp+=" . l:dir
 endfunction
 let s:opam_configuration['merlin'] = function('OpamConfMerlin')
 
 let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
 let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
 let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
 for tool in s:opam_packages
   " Respect package order (merlin should be after ocp-index)
   if count(s:opam_available_tools, tool) > 0
     call s:opam_configuration[tool]()
   endif
 endfor
 " ## end of OPAM user-setup addition for vim / base ## keep this line
 "
 "
 " ctags
set tags=./tags;,tags

