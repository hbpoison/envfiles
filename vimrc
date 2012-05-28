set history=50
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set nobackup
set nocompatible  " Use Vim settings, rather then Vi settings
set noswapfile
set nowritebackup
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands

" pathogen
call pathogen#infect()

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on

augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" indent
set autoindent
set smartindent

" Features in 7.3
set title
set encoding=utf8

" stuff
set showmode
set cursorline
set ttyfast

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" set undo settings
set undodir=~/.vim/undofiles
set undofile

" folding settings
set foldmethod=indent
set foldnestmax=3
set nofoldenable

" Don't continue comments when pushing o/O
set formatoptions-=o

" some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

" hide buffers when not displayed
set hidden

" leader key
let mapleader=","

" Searching / moving
set ignorecase
set smartcase
set gdefault
set showmatch
set hlsearch
nnoremap <Leader><Space> :noh<cr>
:nmap <Space> /

" Handle long lines correctly
set wrap
set textwidth=80
set formatoptions=n
set colorcolumn=80
set tw=80

" Move around lines
nnoremap j gj
nnoremap k gk

" Map ESC
imap jj <ESC>
nnoremap ; :

" Map ,a to Ack
"nnoremap <Leader>a :Ack
" Rotating among results in an ack search
"map <C-n> :cn<cr>
"map <C-p> :cp<cr>

" Map ,co to TComment
map <Leader>co :TComment<cr>

" Splits ,v to new vertical split and switch to it
nnoremap <Leader>v <C-w>v<C-w>l
nnoremap <Leader>h :split<cr><C-w>j
" Key mapping for window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Swith between buffers
noremap <tab> :bn<cr>
noremap <S-tab> :bp<cr>

" NERDTree
let NERDTreeShowBookmarks=1
let NERDChristmasTree=1
silent! nmap <silent> <Leader>p :NERDTreeToggle<cr>
nnoremap <silent> <C-f> :NERDTreeFind<cr>

" AutoClose
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}'}
let g:AutoCloseProtectedRegions = ["Character"]

" backup & swap file
set nobackup
set nowritebackup
set noswapfile

" BLAAAME
vmap <Leader>gb :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p<CR>

" Tabularize
"nmap <leader>a\| :Tab /\|<CR>
"vmap <leader>a\| :Tab /\|<CR>
"nmap <leader>a= :Tab /=<CR>
"vmap <leader>a= :Tab /=<CR>
"nmap <leader>a: :Tab /:\zs<CR>
"vmap <leader>a: :Tab /:\zs<CR>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" map to bufexplorer
nnoremap <Leader>b :BufExplorer<cr>

" Command-T configuration
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1
nnoremap <Leader>t :CommandT<cr>

" ragtag mapping
inoremap <M-o> <ESC>o
inoremap <C-j> <Down>
let g:ragtag_global_maps=1

" mark syntax errors with :signs
let g:syntastic_enable_signs=1

" Gundo key mapping
nnoremap <F5> :GundoToggle<cr>

" Specky
let g:speckyQuoteSwitcherKey = "<Leader>s'"
let g:speckySpecSwitcherKey = "<Leader>sx"
let g:speckyRunSpecKey = "<Leader>ss"
let g:speckyWindowType = 1

"define :Lorem command to dump in a paragraph of lorem ipsum
command! -nargs=0 Lorem :normal iLorem ipsum dolor sit amet, consectetur
      \ adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore
      \ magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
      \ ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
      \ irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
      \ fugiat nulla pariatur.  Excepteur sint occaecat cupidatat non
      \ proident, sunt in culpa qui officia deserunt mollit anim id est
      \ laborum

" :SudoW to save file using sudo (must be already authorised, eg sudo -v)
command! -bar -nargs=0 SudoW   :silent exe "write !sudo tee % >/dev/null"|silent edit!

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

" Color scheme
colorscheme ir_black
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t

" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"


" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Improve syntax highlighting
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile *.md set filetype=markdown
