" Copy or link this file to ~/.vimrc


" SETTINGS --------------------------------------------------------------- {{{ "

" General
    set nocompatible              " Use Vim defaults instead of vi
    set number                    " Show line numbers
    set nowrap
    set showmatch                 " Highlight matching brackets
    set hidden                    " Allow unsaved buffers to stay open
    set clipboard=unnamedplus     " Use system clipboard (if supported)

" Searching
    set ignorecase smartcase      " Smart case searching
    set incsearch                 " Search as you type
    set hlsearch                  " Highlight all search results

" Indentation
    set tabstop=4               " Tab is equal to 4 spaces
    set expandtab               " Pressing Tab inserts spaces
    set shiftwidth=4            " Indentation in spaces
    set softtabstop=4           " Backspace deletes 4 spaces
    set autoindent
    set smartindent

" Syntax & Filetypes
    syntax on                     " Enable syntax highlighting
    filetype plugin indent on      " Enable filetype detection, plugins, and indentation
    let g:python_highlight_all = 1

" Appearance
    set termguicolors             " Enable 24-bit colors (if terminal supports it)
    " colorscheme tokyonight
    set cursorline                " Highlight the current line
    set background=dark           " Use dark mode (or 'light')

" Usability
    set scrolloff=5               " Keep 5 lines visible when scrolling
    set splitbelow splitright     " Split windows open below and to the right
    set showcmd                   " Show incomplete command in status line
    set mouse=a                   " Enable mouse support

" Optional Quality of Life
    set undofile                  " Persistent undo
    set backupdir=~/.vim/backup// " Store backups here
    set undodir=~/.vim/undo//     " Store undo history here
    silent! call mkdir(&backupdir, 'p')
    silent! call mkdir(&undodir, 'p')

" Wildmenu
    set wildmenu
    set wildmode=list:longest
    set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" }}} "


" PLUGINS ---------------------------------------------------------------- {{{ "

call plug#begin('~/.vim/plugged')
 
    Plug 'preservim/nerdtree'
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'jiangmiao/auto-pairs'

call plug#end()

colorscheme tokyonight

" }}}


" MAPPINGS --------------------------------------------------------------- {{{ "

" Clear search highlights with Space
    nnoremap <space> :nohlsearch<CR>

" Escape terminal mode with esc
    tnoremap <Esc> <C-\><C-n>

" Inserting lines
    nnoremap o o<esc>
    nnoremap O O<esc>

" NERDTree specific mappings.
    " Map the F3 key to toggle NERDTree open and close.
    nnoremap <F3> :NERDTreeToggle<cr>
    " Have nerdtree ignore certain files and directories.
    let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" }}} "


" VIMSCRIPT -------------------------------------------------------------- {{{ "

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}} "


" STATUS LINE ------------------------------------------------------------ {{{ "

set statusline=

" Status line left side.
set statusline+=%F\ %m\ %y\ %r\ %h

set statusline+=%=

" Status line right side.
set statusline+=%l/%L\ %c\ %p%%

" Show the status on the second to last line.
set laststatus=2

" Hide ruler
set noruler

" }}} "
