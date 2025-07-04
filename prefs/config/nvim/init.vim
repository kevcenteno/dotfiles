scriptencoding utf-8
set encoding=utf-8
set termguicolors

" polyglot
let g:polyglot_disabled = ['go']

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'github/copilot.vim'

" Deps for avante
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'

" Optional deps for avante
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-tree/nvim-web-devicons' "or Plug 'echasnovski/mini.icons'
Plug 'HakonHarnes/img-clip.nvim'
Plug 'zbirenbaum/copilot.lua'

Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }
call plug#end()

syntax on                         " show syntax highlighting
set re=0                          " Fix slow typescript syntax regex
filetype plugin indent on
set autoindent                    " set auto indent
set backspace=indent,eol,start    " fix backspace behavior
set ts=2                          " set indent to 2 spaces
set shiftwidth=2
set expandtab                     " use spaces, not tab characters
set nocompatible                  " don't need to be compatible with old vim
set number                        " show line numbers
set showmatch                     " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set cursorline                    " highlight current line
set smartcase                     " pay attention to case when caps are used
set incsearch                     " show search results as I type
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set ruler                         " show row and column in footer
set scrolloff=2                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set list listchars=tab:»-         " show extra space characters
set nofoldenable                  " disable code folding
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
set wildignore+=*/node_modules/*,*/bower_components/*,*/.tmp/*,*/dist/*,*.tgz,*.gz
set updatetime=300
set signcolumn=yes
set mouse=

" set dark background and color scheme
set background=dark
colorscheme molokai


" set up some custom colors
highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
highlight LineNr       ctermbg=236   ctermfg=240
highlight CursorLineNr ctermbg=236   ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238   ctermfg=0
highlight IncSearch    ctermbg=0     ctermfg=3
highlight Search       ctermbg=0     ctermfg=9
highlight Visual       ctermbg=3     ctermfg=0
highlight SpellBad     ctermbg=0     ctermfg=1

au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl

" set leader key to comma
let mapleader = "\<Space>"

nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :split<CR>
nnoremap <Leader>, 2<C-w><
nnoremap <Leader>. 2<C-w>>
nnoremap <Leader>- 2<C-w>-
nnoremap <Leader>= 2<C-w>+
nnoremap <Leader>w <C-w>w

" unmap F1 help
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" map . in visual mode
vnoremap . :norm.<cr>

" die hash rockets, die!
vnoremap <leader>h :s/:\(\w*\) *=>/\1:/g<cr>

" <leader><leader> to switch to last buffer
nnoremap <leader><leader> <c-^>


" check code complexity and duplication for current file
map <leader>x :!clear &&
 \ echo '----- Complexity -----' && flog % &&
 \ echo '\n----- Duplication -----' && flay %<cr>


" clear the command line and search highlighting
noremap <C-l> :nohlsearch<CR>

" map ctrl-c to <esc>.  this forces InsertLeave to execute
:ino <C-C> <Esc>

" add :Plain command for converting text to plaintext
command! Plain execute "%s/’/'/ge | %s/[“”]/\"/ge | %s/—/-/ge"

" hint to keep lines short
if exists('+colorcolumn')
  set colorcolumn=100
endif



" fzf
nnoremap <Leader>o :GFiles --cached --others --exclude-standard<CR>

set noshowmode shortmess+=c
set completeopt-=preview
set completeopt+=menuone,noinsert,noselect

" Ale
" let g:ale_sign_column_always = 1

" Coc
let g:coc_global_extensions = ['coc-css', 'coc-go', 'coc-json', 'coc-tsserver', 'coc-prettier', 'coc-eslint', 'coc-pyright']
autocmd FileType scss setl iskeyword+=@-@

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <Leader>j <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>k <Plug>(coc-diagnostic-prev)

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Golang: save on import
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Remap for copilot
imap <silent><script><expr> <C-h> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

lua require'configs/treesitter'
lua require'configs/colors'
lua require'configs/avante'
