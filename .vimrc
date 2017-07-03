set nocompatible
filetype off
syntax on
filetype plugin indent on
call pathogen#infect()
call pathogen#helptags()
set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set shiftwidth=2
set softtabstop=2
set expandtab
autocmd vimenter * if !argc() | NERDTree | endif
autocmd VimEnter * wincmd p
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swo$','\.swp$','\.git','\.hg','\.svn','\.bzr']
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
syntax on
colorscheme slate
map <C-n> :NERDTreeToggle<CR>
set bdir-=.
set bdir+=/tmp
set dir-=.
set dir+=/tmp
map <Leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-overwin-f2)
nmap <Leader>f <Plug>(easymotion-overwin-f)

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
highlight ColorColumn ctermbg=0
set colorcolumn=80

" air-line
let g:airline_powerline_fonts = 1

"autocmd VimEnter * :IndentGuidesEnable
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
"autocmd VimEnter * :hi IndentGuidesEven ctermbg=None    
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_section_a = airline#section#create(['mode', ' ', gitbranch#name()])
let g:airline_theme = 'light'
