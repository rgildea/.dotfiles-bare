call plug#begin()

" Editing
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" JS/TS syntax
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'

" Formatting + linting
Plug 'prettier/vim-prettier', { 'do': 'npm install --frozen-lockfile 2>/dev/null || npm install' }
Plug 'dense-analysis/ale'

" Fuzzy finding (uses Homebrew fzf binary)
Plug '/opt/homebrew/opt/fzf'
Plug 'junegunn/fzf.vim'

" AI
Plug 'github/copilot.vim'

call plug#end()

" --- Core settings ---
let mapleader = " "
set tags=./tags

" --- Key mappings ---
nmap <leader>vr :tabedit $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>F  :Files .<cr>
imap jk <esc>
imap kj <esc>
imap <C-s> <esc>:w<cr>
map  <C-s> :w<cr>

" Move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" --- Color ---
colorscheme base16-darktooth

" --- netrw sidebar ---
let g:netrw_banner    = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize   = 25

" --- Prettier ---
let g:prettier#exec_cmd_async        = 1
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

" --- ALE (linting + fixing) ---
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'typescript': ['eslint', 'tsserver'],
\}
let g:ale_fixers = {
\  'javascript': ['prettier'],
\  'typescript': ['prettier'],
\}
let g:ale_fix_on_save = 1

" --- Copilot ---
let g:copilot_node_command = expand('~/.asdf/installs/nodejs/lts/bin/node')

" --- Auto-create parent dirs on save ---
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * if expand('<afile>')!~#'^\w\+:/' &&
    \ !isdirectory(expand('%:h'))
    \ | execute 'silent! !mkdir -p '.shellescape(expand('%:h'), 1)
    \ | redraw! | endif
augroup END
