"  ___  _  _  ____  ___  _____  ____
" / _ \( \/ )(  _ \/ __)(  _  )(  _ \
"( (_) ))  (  ) _ <\__ \ )(_)(  )(_) )
" \___/(_/\_)(____/(___/(_____)(____/

""" START Vundle Configuration

" Disable file type for vundle
    filetype off " required

" set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()"

" let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

" Vim Encanse
    Plugin 'ervandew/supertab'

" Generic Support
    Plugin 'xolox/vim-misc'
    Plugin 'xolox/vim-easytags'

" Git Support
    Plugin 'kablamo/vim-git-log'
    Plugin 'gregsexton/gitv'
    Plugin 'tpope/vim-fugitive'

" Syntax
    Plugin 'pangloss/vim-javascript'
    Plugin 'posva/vim-vue'
    Plugin 'dNitro/vim-pug-complete'
    Plugin 'PotatoesMaster/i3-vim-syntax'

" Interface
    Plugin 'KeitaNakamura/neodark.vim'
    Plugin 'vim-airline/vim-airline'
    Plugin 'Yggdroot/indentLine'

call vundle#end()            " required
filetype plugin indent on    " required
""" END Vundle Configuration

"""""""""""""""""""""""""""
" Configuration Section
"""""""""""""""""""""""""""

" Basic config
    set clipboard=unnamedplus
	set encoding=utf8
	set nocompatible
	set tabstop=4
	set shiftwidth=4
    set smarttab
	set expandtab
    set nowrap
    " Use deoplete.
    " let g:deoplete#enable_at_startup = 1
    autocmd BufWritePre * %s/\s\+$//e
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Style
    syntax on
    filetype plugin on
	set number
	set relativenumber
    set cursorline
    set laststatus=2
    set t_Co=256
    let base16colorspace=256
    let g:javascript_plugin_jsdoc = 1
    let g:javascript_plugin_ngdoc = 1
    let g:javascript_plugin_flow = 1
    colorscheme neodark
    let g:neodark#terminal_transparent = 1
" Splits
	set splitbelow
	set splitright

" Enable autocompletion:
	set wildmode=longest,list,full
 	set wildmenu

"""""""""""""""""""""""""
" Mappings configurationn
"""""""""""""""""""""""""

" C-T for new tab
 	nnoremap <C-t> :tabnew<cr>

" Split Pane
    nnoremap <C-r> :split<cr>
    nnoremap <C-e> :vsplit<cr>

" Shortcutting split navigation, saving a keypress:
 	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Open the selected text in a split (i.e. should be a file).
 	map <leader>o "oyaW:sp <C-R>o<CR>
	xnoremap <leader>o "oy<esc>:sp <C-R>o<CR>
	vnoremap <leader>o "oy<esc>:sp <C-R>o<CR>
" Copy selected text to system clipboard (requires gvim installed):
 	vnoremap <C-c> "*y :let @+=@*<CR>
