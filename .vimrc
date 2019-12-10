" Install plugins
call plug#begin('~/.local/share/nvim/plugged')
" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'jalvesaq/Nvim-R'
Plug 'lervag/vimtex'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'
Plug 'chrisbra/csv.vim'
Plug 'ervandew/supertab'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
call plug#end()

" Allow search into subfolders
set path+=**

" Display all matching files
"  set wildmenu

set clipboard=unnamedplus
set tabstop=2
set shiftwidth=2
set expandtab

" Insert return after 80 chars in tex and md files
" set textwidth=80
autocmd bufreadpre *.tex setlocal textwidth=80
autocmd bufreadpre *.md setlocal textwidth=80
set autoindent
set number " always set line numbers on
autocmd BufEnter * :syntax sync fromstart

" Vimwiki settings
set nocompatible
filetype plugin on
syntax on
let g:vimwiki_list = [{'path': '~/OneDrive/vimwiki'}]

" Vimtex Settings
let g:tex_flavor = 'latex'
let g:vimtex_view_method = "zathura"
let g:vimtex_compiler_progname = "nvr"

" Nvim-R Settings
nmap <LocalLeader>: :RSend 
" remapping the basic :: send line
nmap <Space> <Plug>RDSendLine
" remapping selection :: send multiple lines
vmap <Space> <Plug>RDSendSelection
" remapping selection :: send multiple lines + echo lines
vmap ,e <Plug>RESendSelection
" remaping 
let R_assign = 2
let R_hl_term = 0
" Use tmux
let R_in_buffer=0

" Pipe %>% shortcut for R documents
autocmd FileType r inoremap <buffer> <LocalLeader>m <Esc>:normal! a %>%<CR>a 
autocmd FileType rnoweb inoremap <buffer> <LocalLeader>m <Esc>:normal! a %>%<CR>a 
autocmd FileType rmd inoremap <buffer> <LocalLeader>m <Esc>:normal! a %>%<CR>a 

" Start R automatically on vim open R or Rmd file
"autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
"autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
" Stop R automatically on vim quit
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

" HTML help in R
"let R_nvimpager = 'no'

" Deoplete settings
let g:deoplete#enable_at_startup = 1
  call deoplete#custom#var('omni', 'input_patterns', {
          \ 'tex': g:vimtex#re#deoplete
          \})
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" terminal emulator key remap
tnoremap <Esc> <C-\><C-n>

