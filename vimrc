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
    Plugin 'Raimondi/delimitMate'
    Plugin 'Valloric/YouCompleteMe'

" Generic Support
    Plugin 'xolox/vim-misc'
    Plugin 'xolox/vim-easytags'

" Git Support
    Plugin 'airblade/vim-gitgutter'
    Plugin 'kablamo/vim-git-log'
    Plugin 'gregsexton/gitv'
    Plugin 'tpope/vim-fugitive'

" Syntax
    Plugin 'othree/html5.vim'
    Plugin 'pangloss/vim-javascript'
    Plugin 'posva/vim-vue'
    Plugin 'PotatoesMaster/i3-vim-syntax'
    Plugin 'digitaltoad/vim-pug'

" Interface
    Plugin 'itchyny/lightline.vim'
    Plugin 'Yggdroot/indentLine'
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
    set wildmenu   
    set path=**
    set incsearch 
    set magic
    set showmatch 
    

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
    let g:ycm_python_binary_path = 'python'
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'

" Ale tune
    let g:ale_sign_error = '✘'
    let g:ale_sign_warning = '▲'
    let g:airline#extensions#ale#enabled = 1
    let g:ycm_python_binary_path = 'python'
	let g:ale_linters = {
	\   'javascript': ['jshint'],
	\   'python': ['flake8']
	\}


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

" Functions
	fun! CleanExtraSpaces()
    	let save_cursor = getpos(".")
    	let old_query = getreg('/')
    	silent! %s/\s\+$//e
    	call setpos('.', save_cursor)
    	call setreg('/', old_query)
	endfun

	function! VisualSelection(direction, extra_filter) range
	    let l:saved_reg = @"
	    execute "normal! vgvy"
	
	    let l:pattern = escape(@", "\\/.*'$^~[]")
	    let l:pattern = substitute(l:pattern, "\n$", "", "")
	
	    if a:direction == 'gv'
	        call CmdLine("Ack '" . l:pattern . "' " )
	    elseif a:direction == 'replace'
	        call CmdLine("%s" . '/'. l:pattern . '/')
	    endif
	
	    let @/ = l:pattern
	    let @" = l:saved_reg
	endfunction

	if has("autocmd")
    	autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()	
	endif

"""""""""""""""""""""""""
" Mappings configurationn
"""""""""""""""""""""""""
    
    nnoremap ,<space> :nohlsearch<CR>
	nmap <silent> <leader>a <Plug>(ale_next_wrap)


" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
    vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
    vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Paste mode
    set pastetoggle=<F3>

" C-T for new tab
    nnoremap <C-t> :tabnew<cr>

" Move a line of text using ALT+[jk]
    nmap <M-j> mz:m+<cr>`z
    nmap <M-k> mz:m-2<cr>`z
    vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
    vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
    
" Shortcutting split navigation, saving a keypress:
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
