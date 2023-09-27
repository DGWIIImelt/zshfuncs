" https://medium.com/geekculture/neovim-configuration-for-beginners-b2116dbbde84
set nocompatible            " disable compatibility to old-time vi
set relativenumber          " adds line numbers relative to current position
set encoding=UTF-8
set number                  " add line numbers
set splitright              " vertical split to right current pane
set splitbelow              " horizontal split below current pane
set scrolloff=8
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set wildmenu
set wildmode=longest,list   " get bash-like tab completions
set cc=160                  " set an 80 column border for good coding style
set termguicolors           " add colors to nvim editor
" set foldmethod=indent       " fold text at same indent depth

let NERDTreeShowHidden=1    " show hidden files in NerdTree pane
let NERDTreeWinSize=30      " set NerdTree pane width / TODO: doesn't seem to be working as desired

filetype plugin on
filetype plugin indent on   " allow auto-indenting depending on file type

syntax on                   " syntax highlighting

" ----------------------------------------------- PLUGINS -----------------------------------------------
" NOTE: run so ~/.config/nvim/initi.nvim && :PlugInstall after adding a new one
call plug#begin("~/.config/nvim/plugged")
 Plug 'nvim-lualine/lualine.nvim'
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
 Plug 'honza/vim-snippets'
 Plug 'scrooloose/nerdtree'
 Plug 'preservim/nerdcommenter'
 Plug 'mhinz/vim-startify'
 Plug 'ryanoasis/vim-devicons'
call plug#end()

lua << END
require('lualine').setup { 
    options = { theme = 'molokai' }
}
END

" ----------------------------------------------- REMAPS ----------------------------------------------
" NOTE: <CR> executes the command
" NOTE:  nnoremap = n: normal, nore: no recursion, map: map over the default command

" telescope fuzzy finder
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope help_tags<cr>

" nerdtree
nnoremap \\ <cmd>NERDTreeToggle<cr>

" custom
" move between panes to left/bottom/top/right
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" TODO: toggle current panes buffer
" presently requires ctrl shift 6

" NOT working!!!
" nnoremap <F5> :grep <C-R><C-W> *<CR>                     " search for the keyword under the cursor in the current directory using the 'grep'

" move line or visually selected block - alt+j/k
"inoremap <A-j> <Esc>:m .+1<CR>==gi
"inoremap <A-k> <Esc>:m .-2<CR>==gi
"vnoremap <A-k> :m '<-2<CR>gv=gv
"vnoremap <A-j> :m '>+1<CR>gv=gv

" move split panes to left/bottom/top/right
" nnoremap <A-h> <C-W>H
" nnoremap <A-j> <C-W>J
" nnoremap <A-k> <C-W>K
" nnoremap <A-l> <C-W>L

" open file in a text by placing text and gf
" nnoremap gf :vert winc f<cr>
" copies filepath to clipboard by pressing yf
" :nnoremap <silent> yf :let @+=expand('%:p')<CR>
" copies pwd to clipboard: command yd
":nnoremap <silent> yd :let @+=expand('%:p:h')<CR>

" ----------------------------------------------- STARTUP SCRIPTS ---------------------------------------------
" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

