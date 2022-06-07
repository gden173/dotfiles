set nocompatible

""""""""""""""""""""""""""""""""""""""
"
" Leader Key
"
""""""""""""""""""""""""""""""""""""""
let mapleader=","

""""""""""""""""""""""""""""""""""""""
"
" Line Configurations
"
""""""""""""""""""""""""""""""""""""""
" Numbered LInes
set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set syntax
set nohlsearch
set splitbelow splitright
set title
set t_Co=256

""""""""""""""""""""""""""""""""""""""""
"  Enable  Syntax
""""""""""""""""""""""""""""""""""""""""
syntax on
filetype plugin indent on

set smarttab
set softtabstop=4
set mouse=a

" Files Browsing
set wildmode=longest,list,full


call plug#begin()

" Tree Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Colorscheme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Formater
Plug 'Chiel92/vim-autoformat'

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc

" Git
Plug 'tpope/vim-fugitive'            " allows git commands in vim session
Plug 'ryanoasis/vim-devicons'

" Autocomplete
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release','do': 'yarn install' }

" Airline Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'ncm2/ncm2' " R Development
Plug 'roxma/nvim-yarp'
Plug 'jalvesaq/Nvim-R'
Plug 'gaalcaras/ncm-R'
"
Plug 'mhinz/vim-startify'            " A start menu for vim
Plug 'jiangmiao/auto-pairs'          " auto pair completion

set encoding=UTF-8

call plug#end()

" turn on spelling and make a spell file
set spelllang=en_au
set spellfile=~/.config/nvim/en.utf-8.add


" https://medium.com/@Aenon/vim-swap-backup-undo-git-2bf353caa02f
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//

" Key Remaps
" jk and k
imap kj <Esc>
imap jk <Esc>

set termguicolors
colorscheme tokyonight

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:python3_host_prog = '/bin/python'

set completeopt=menu,preview

"""""""""""""""""""""""""""""""""""""""
" COC Settings
""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=number

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


let g:coc_global_extension = [
			\'coc-snippets',
			\'coc-python',
			\'coc-json',
			\ ]
set hidden
""""""""""""""""""""""""""""""""""""""""
"  Shell Scripting
""""""""""""""""""""""""""""""""""""""""
" Checks  Shell Scripts
map <leader>s :!clear && shellcheck %<CR>


" Latex
autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!

"  Beamer Commands
autocmd FileType md  nnoremap  Pres silent!  execute  "!clear  &&  pandoc  %  -t  beamer $($(basename %).pdf)2>&1 "  |  redraw!


" settings :: Nvim-R plugin

imap <leader>m  %>%

" R output is highlighted with current colorscheme
let g:rout_follow_colorscheme = 1

" R commands in R output are highlighted
let g:Rout_more_colors = 1
" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"


" Window Splits
" Initial  Splits  are  Right
set splitbelow splitright


" Remap splits navigation to just CTRL + hjkl
" May  need  to see  how this works  with  tmux
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l



" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>

" Change 2 split windows from vert to horiz or horiz to vert
map <leader>th <C-w>t<C-w>H
map <leader>tk <C-w>t<C-w>K



" vim-autoformat
noremap <F4> :Autoformat<CR>



" --------------------------------------------------------
" COC-VIM TAB SETTINGS START

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" COC-VIM TAB SETTINGS END
" --------------------------------------------------------
 
 if has("autocmd") && exists("+omnifunc")
	autocmd Filetype *
		    \	if &omnifunc == "" |
		    \		setlocal omnifunc=syntaxcomplete#Complete |
		    \	endif
    endif
