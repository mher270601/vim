"let &t_TI=''
"let &t_TE=''

set termguicolors
set ruler

set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on

set history=700

" lua init plugins
lua require('plugins')

" Allow copy to local server clipboard
" Don't use 'unnamedplus'
set clipboard+=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""
" Set colors
set t_Co=256

silent! colorscheme nightfox

"""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""
" Set Status bar options
"set laststatus=2
"set statusline=
"set statusline+=%<%F			"path
"set statusline+=[%n]%r%m
"set statusline+=%=[r:%l/%L]	"Rownumber/total (%)
"set statusline+=[c:%v](%3p%%)	"Virtual Column #
"highlight StatusLine ctermfg=black ctermbg=grey cterm=bold
"highlight StatusLineNC ctermfg=black ctermbg=grey

"""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""
" Highlight tabs
highlight TabLineFill ctermfg=black ctermbg=black cterm=bold
highlight TabLine ctermfg=grey ctermbg=black
highlight TabLineSel ctermfg=black ctermbg=grey
highlight Title ctermfg=grey ctermbg=black
"""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""
" ctags options
set autochdir
set tags=./tags,tags;$HOME,/home/lab/kernels/linux/tags

"""""""""""""""""""""""""""""""""""""""""""""""
" Resize window
nnoremap <silent> <c-Up> :resize -1<CR>
nnoremap <silent> <c-Down> :resize +1<CR>
nnoremap <silent> <c-left> :vertical resize -1<CR>
nnoremap <silent> <c-right> :vertical resize +1<CR>

"""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""
" Change comment coloring
highlight Comment ctermfg=37 cterm=none
highlight Statement ctermfg=214 cterm=none
highlight Search ctermfg=black ctermbg=yellow
highlight Constant ctermfg=203
highlight PreProc ctermfg=133

highlight Error None

" highlight fold color
highlight Folded ctermbg=black

" highlight Visual
highlight Visual ctermbg=grey ctermfg=black

" Set interractive command
set shellcmdflag=-ic

" Highlight trailing whitespaces
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Show leading whitespace that includes spaces, and trailing whitespace.
"highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd BufWinEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" ignore case when search
set ignorecase

" Highlight search
set hlsearch

" Highlight all search result on page
set incsearch

" Clear cursor shape so we don't see this <Esc>[2<Space>q issue
set t_SH=

" set auto indent
set ai
" set smart indent
set si
" set wrap lines
set nowrap

" Turn off sounds
set noerrorbells
set visualbell
set t_vb=
set tm=500

" Turn off backup, no need for SWAP file
set nobackup
set nowb
set noswapfile

set shell=/bin/bash\ --rcfile\ ~/.bashrc

"""""""""""""""""""""""""""""""""""""""""""""""
" set tab length
set noexpandtab
set shiftwidth=8
set tabstop=8

"""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*.o,*.aa

""""""""""""""""""""""""""""""""""""""""""""""""
" Set relative line number
" set rnu
set number
set norelativenumber
highlight LineNr ctermfg=grey ctermbg=black
highlight CursorLineNr ctermfg=white ctermbg=black
""""""""""""""""""""""""""""""""""""""""""""""""

" set wrapped lines as break lines
map j gj
map k gk

"""""""""""""""""""""""""""""""""""""""""""""""

" Disable highlight when press \ and enter
map <silent> <leader><cr> :noh<cr>

nnoremap <Leader>rtw :%s/\s\+$//e<CR>

set backspace=2
set backspace=indent,eol,start,

" tabs remapping
nnoremap th :tabprev<CR>
nnoremap tj :tablast<CR>
nnoremap tk :tabfirst<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>
nnoremap td :tabclose<CR>
nnoremap ts :tab split<CR>
nnoremap tt :tabedit<Space>
nnoremap tm :tabm<Space>
nnoremap t1 1gt
nnoremap t2 2gt
nnoremap t3 3gt
nnoremap t4 4gt
nnoremap t5 5gt
nnoremap t6 6gt
nnoremap t7 7gt
nnoremap t8 8gt
nnoremap t9 9gt

" Automatically pops up quickfix window to open any grep
autocmd QuickFixCmdPost *grep* cwindow

"command -nargs=0 Format call FormatCode()

autocmd BufNewFile,BufRead *.patch.snps set filetype=gitcommit

" Perl style
autocmd FileType perl,sh,python,lua set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4

" Split and add terminal
command VT below vertical terminal
command T below terminal

" Telescope plugin
nnoremap <leader>ff <cmd>lua require('nvim-rooter').rooter() require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('nvim-rooter').rooter() require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fd :Telescope file_browser<CR>

" Tig plugin
let g:tig_on_exit = 'BufDel!'
let g:tig_default_command = ''
nnoremap <leader>t :Tig status<CR>
nnoremap <leader>tb :Tig! blame +<CR>
nnoremap <leader>T :Tig<CR>
