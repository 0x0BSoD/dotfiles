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
    Plugin 'w0rp/ale'
    Bundle 'Valloric/YouCompleteMe'
    Plugin 'ervandew/supertab'
    Plugin 'Raimondi/delimitMate'
    Plugin 'Yggdroot/indentLine'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'junegunn/fzf'

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
    Plugin 'itchyny/lightline.vim'
    Plugin 'altercation/vim-colors-solarized'

call vundle#end()            " required
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
    " let g:deoplete#enable_at_startup = 1
    autocmd BufWritePre * %s/\s\+$//e
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Style
    syntax on
    filetype plugin indent on
    set number
    set relativenumber
    set ruler
    set showcmd
    set incsearch
    set hlsearch
    set cursorline
    set laststatus=2
    set t_Co=256
    set background=dark
    colorscheme solarized

" YCM
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_use_ultisnips_completer = 1
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_complete_in_comments = 1
    let g:ycm_complete_in_strings = 1
    let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']

" Ale tune
    let g:ale_sign_error = '☠'
    let g:ale_sign_warning = '⚠'
    let g:airline#extensions#ale#enabled = 1
    let g:ycm_python_binary_path = 'python'

" Easy tags tune
    set tags=./tags;,~/.vimtags
    let g:easytags_events = ['BufReadPost', 'BufWritePost']
    let g:easytags_async = 1
    let g:easytags_dynamic_files = 2
    let g:easytags_resolve_links = 1
    let g:easytags_suppress_ctags_warning = 1

" DelimitMate tune
    let delimitMate_expand_cr = 1
    augroup mydelimitMate
      au!
      au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
      au FileType tex let b:delimitMate_quotes = "
      au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
      au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
    augroup END
    autocmd StdinReadPre * let s:std_in=1

" netrw tune
    let g:netrw_banner = 0
    let g:netrw_liststyle = 3

" Splits
    set splitbelow
    set splitright

" Guide lines tune

"""""""""""""""""""""""""
" Mappings configurationn
"""""""""""""""""""""""""

" fzf remap
    nmap <C-p> :FZF<cr>

" Paste mode
    set pastetoggle=<F3>

" C-T for new tab
    nnoremap <C-t> :tabnew<cr>

" Split Pane
    nnoremap <C-q> :split<cr>
    nnoremap <C-w> :vsplit<cr>

" Shortcutting split navigation, saving a keypress:
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

" Split size
    nmap <Left> :vertical resize +5<cr>
    nmap <Right> :vertical resize -5<cr>
    nmap <Up> :resize +5<cr>
    nmap <Down> :resize -5<cr>


" Open the selected text in a split (i.e. should be a file).
    map <leader>o "oyaW:sp <C-R>o<CR>
    xnoremap <leader>o "oy<esc>:sp <C-R>o<CR>
    vnoremap <leader>o "oy<esc>:sp <C-R>o<CR>
