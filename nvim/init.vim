call plug#begin()
" general tools 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
" color scheme
Plug 'arcticicestudio/nord-vim'
Plug 'jonathanfilip/vim-lucius'
Plug 'rakr/vim-two-firewatch'
" programming language specific
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries' }
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'qpkorr/vim-bufkill'
Plug 'kaicataldo/material.vim'
Plug 'hzchirs/vim-material'
Plug 'Yggdroot/indentLine'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'morhetz/gruvbox'
call plug#end() 

" dispaly the line number by default
set number
" highlight the current line
set cursorline

syntax on
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" fzf & ag shortcuts 
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>g :Ag<CR>

" pane navigation shortcuts 
nmap <Leader>q :q<CR>
nmap <Leader>v :vsplit<CR>
nmap <Leader>s :split<CR>

" buffer navigation shortcuts 
nmap <Tab> :bn<CR>

" toggle linenumber shortcuts 
nmap <Leader>n :set invnumber<CR>
set pastetoggle=<F2>

" nerdtree shortcuts
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-m> :TagbarToggle<CR>

set mouse=a

" set tab behavior
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" golang setting
" let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:syntastic_go_checkers = ['golint']
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_auto_type_info =1
let g:go_fmt_autosave = 1
let g:go_mod_fmt_autosave = 1
let g:go_gopls_enabled = 1

let g:go_def_mapping_enabled = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_bold_vertical_split_line = 1

" lightline setting
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" disable preview window
set completeopt-=preview 
" disable case sensitive searching
set ignorecase

highlight Comment cterm=italic gui=italic 
set termguicolors
set colorcolumn=80

" vagrantfile syntax highlight
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby

" setting for code folding
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=2

" configuration for yaml
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
set foldlevel=99

for rcfile in split(globpath("~/.config/nvim/config-files", "*.vim"), '\n') 
    execute('source '.rcfile)
endfor

" enable syntax highlighting for large file
syntax sync minlines=10000
set mmp=5000

" disable latex symbol conversion
let g:tex_conceal = ""
