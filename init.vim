call plug#begin('~/.config/nvim/plugged')
" Installed plugins
Plug 'morhetz/gruvbox' "gruv colorscheme
Plug 'jacoborus/tender.vim' "24bit colorscheme
Plug 'vimwiki/vimwiki' 
Plug 'tools-life/taskwiki'
Plug 'chipsenkbeil/vimwiki-server.nvim', { 'tag': 'v0.1.0-alpha.5' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'ap/vim-css-color'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive' "Git
Plug 'lambdalisue/suda.vim' " plugin to read or write files with sudo command
Plug 'mattn/emmet-vim' " vim plugins for HTML and CSS
Plug 'mhinz/vim-startify' " start screen
Plug 'mbbill/undotree' " undo is a tree, visualize it
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-repeat'
Plug 'ryanoasis/vim-devicons'
Plug 'hoob3rt/lualine.nvim'
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'overcache/NeoSolarized' " solarized colorscheme
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'google/vim-maktaba' " Needed by vim-bazel plugin
Plug 'bazelbuild/vim-bazel' " Invoke Bazel
Plug 'cappyzawa/starlark.vim'
Plug 'svermeulen/vim-macrobatics' "Play, edit record macros
Plug 'BurntSushi/ripgrep'
Plug 'tpope/vim-unimpaired' 
Plug 'idanarye/vim-merginal' " fugitive merge plugin
Plug 'tpope/vim-rhubarb' " Open Github in browser from vim
Plug 'junegunn/gv.vim' " Git history
Plug 'AGhost-7/critiq.vim' " Pull Requests in vim 
Plug 'psf/black', { 'branch': 'stable' }
call plug#end()

function! IsOnHost(hostname)
    return match(system("echo -n $HOST"), a:hostname) >= 0
endfunction

if exists("&termguicolors") && exists("&winblend")
   syntax enable
   set termguicolors
   set winblend=0
   set wildoptions=pum
   set pumblend=5
   set background=dark
  " Use NeoSolarized
   let g:neosolarized_termtrans=1
   runtime ./colors/NeoSolarized.vim
   colorscheme NeoSolarized
endif

set cursorline
 "set cursorcolumn

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
 augroup END

if &term =~ "screen"
   autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
   autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif


" Neovim config
syntax enable
syntax on
set scrolloff=8 " start to scroll as you get close to bottom of screen
set undodir=~/.config/nvim/undodir " set undotree file directory
set undofile " set undotree to save to file
set number relativenumber " sets line numbers relative to where you are up/downr
set nu " shows the line number you are on
set nowrap " set no soft wrap
set tabstop=2 softtabstop=2 " set tab size
set shiftwidth=2 " affect amount of indentation
set expandtab " set that tab will insert softabstop amount of space characters
set nowritebackup                                            
set noswapfile
set nobackup
set breakindent                                      
set smartindent
set smartcase
set incsearch
set hidden
set updatetime=250
set shortmess+=c
set noshowmode
set splitright
let mapleader=" "
" " Panel switching
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>
" " Split panel
nnoremap <leader>v <C-w>v
nnoremap <leader>s <C-w>s
" " Map yanked to clipboard
vnoremap <C-c> "*y
" " Map show undo tree
nnoremap <leader>u :UndotreeShow<CR>
" " Map to open current file in NERDTree and set size
nnoremap <leader>pv :NERDTreeFind<bar> :vertical resize 45<CR>
" " Line moving
" " " Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" " Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
" " Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" " Map escape for terminal emulator
tnoremap <Esc> <C-\><C-n>
" " Map to replace text under cursor
nnoremap <leader>sr :%s/\<<C-r><C-w>\>/

" NERDTree
let g:NERDTreeShowHidden = 1 
let g:NERDTreeMinimalUI = 1 " hide helper
let g:NERDTreeIgnore = ['^node_modules$'] " ignore node_modules to increase load speed 
let g:NERDTreeStatusline = '' " set to empty to use lightline
" " Toggle
noremap <silent> <C-b> :NERDTreeToggle<CR>
" " Close window if NERDTree is the last one
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree Syntax Highlight
" " Enables folder icon highlighting using exact match
let g:NERDTreeHighlightFolders = 1 
" " Highlights the folder name
let g:NERDTreeHighlightFoldersFullName = 1 
" " Color customization
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
" " This line is needed to avoid error
let g:NERDTreeExtensionHighlightColor = {} 
" " Sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['css'] = s:blue 
" " This line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor = {} 
" " Sets the color for .gitignore files
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange 
" " This line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor = {} 
" " Sets the color for files ending with _spec.rb
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red 
" " Sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFolderSymbolColor = s:beige 
" " Sets the color for files that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue 

" NERDTree Git Plugin
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" Nerd Commenter
" " Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" " Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" " Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" " Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" " Map ++ to call NERD Commenter and use iTerm key bindings 
" " to bind Ctmd+/ to ++
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" Fuzzy search
nnoremap <C-p> :GFiles<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" ALE (Asynchronous Lint Engine)
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

" Lightline
let g:lightline = {
  \     'colorscheme': 'powerlineish',
  \     'active': {
  \         'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'filename', 'modified'], ],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     },
  \     'component_function': {
  \         'gitbranch': 'FugitiveHead'
  \     },
  \ }

" Suda
let g:suda_smart_edit = 1
let g:suda#prefix = ['suda://', 'sudo://', '_://']

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" The Silver Searcher
if executable('ag')
  " " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" " bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" " bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" Repeat vim
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
nnoremap \ :Ag<SPACE>

set encoding=UTF-8
let g:webdevicons_enable_startify = 1
set guifont=Hack\ Nerd\ Font:h11

" -----------------------------------
" Vimwiki

if IsOnHost('DavidsMacmini.monkeybrains.net')
 let g:vimwiki_list = [
                        \{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'},
                        \{'path': '~/vimwiki_personal', 'syntax': 'markdown', 'ext': '.md'},
                \]
else
 let g:vimwiki_list = [
                        \{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'},
                \]
endif

let g:vimwiki_folding = 'list'
let g:vimwiki_hl_headers = 1  " use alternating colours for different heading levels
let g:vimwiki_global_ext = 0 " don't treat all md files as vimwiki
let g:vimwiki_markdown_link_ext = 1 " add markdown file extension when generating links
let g:taskwiki_markdown_syntax = 'markdown'

autocmd BufNewFile */diary/????-??-??.md call s:new_vimwiki_diary_template()

function s:new_vimwiki_diary_template()
" If it's Friday, open a end of week lookback template
   if system('date +%u') == 5
        read ~/vimwiki/Diary\ TemplateEndOfWeek.md | execute "normal ggdd"
    else
        read  ~/vimwiki/Diary\ Template.md | execute "normal ggdd"
    end
endfunction

" Disable vim-go go to definition so that COC LSP is used
let g:go_def_mapping_enabled = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

set conceallevel=0 " So that I can see `` and full urls in markdown files 

map <F3> :VimwikiDiaryPrevDay<CR>
map <F4> :VimwikiDiaryNextDay<CR>

" --------------------------------
" vim-macrobatics

" --------------------------------
"  Meginal
map <leader>gb :MerginalToggle<CR>

highlight CocErrorHighlight ctermfg=Red  guifg=#ff0000
highlight FgCocErrorFloatBgCocFloating ctermfg=Black ctermbg=White guifg=Grey82 guibg=Black
