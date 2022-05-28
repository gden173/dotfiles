""""""""""""""""""""""""""""""""""""""
" __     _____ __  __ ____   ____
" \ \   / /_ _|  \/  |  _ \ / ___|
"  \ \ / / | || |\/| | |_) | |
"   \ V /  | || |  | |  _ <| |___
"    \_/  |___|_|  |_|_| \_\\____|
"
"
"  
"
"
""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""
"
" Leader Key
"
""""""""""""""""""""""""""""""""""""""
let mapleader=" "



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

""""""""""""""""""""""""""""""""""""""""
"  Enable  Syntax 
""""""""""""""""""""""""""""""""""""""""

syntax on

filetype plugin on

set smarttab
set softtabstop=4
set mouse=a

" Files Browsing
set wildmode=longest,list,full


call plug#begin()

Plug 'tanvirtin/monokai.nvim'

Plug 'nvim-treesitter/nvim-treesitter'

" Plug 'nvim-orgmode/orgmode'

" Formater
Plug 'Chiel92/vim-autoformat'
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'tpope/vim-fugitive'            " allows git commands in vim session
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
" Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
" Plug 'ncm2/ncm2' " R Development
" Plug 'roxma/nvim-yarp'
" Plug 'jalvesaq/Nvim-R'
" Plug 'gaalcaras/ncm-R'
Plug 'mhinz/vim-startify'            " A start menu for vim
Plug 'tpope/vim-surround'            " replace surrounding characters
Plug 'jiangmiao/auto-pairs'          " auto pair completion
set encoding=UTF-8

call plug#end()


colorscheme monokai_pro

" Key Remaps
imap jj <Esc>


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

" turn on spelling and make a spell file
set spelllang=en_au
set spellfile=~/.config/nvim/en.utf-8.add


:set completeopt-=preview " For No Previews



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

