set nocompatible              " be iMproved, required
filetype off                  " required

" Use OS clipboard for copypasta
" set clipboard=unnamed

" Enable OS mouse clicking and scrolling
"
" Note for Mac OS X: Requires SIMBL and MouseTerm
"
" http://www.culater.net/software/SIMBL/SIMBL.php
" https://bitheap.org/mouseterm/
if has("mouse")
   set mouse=a
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')

" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" " plugins here
"
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'beloglazov/vim-online-thesaurus'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'bling/vim-airline'
Plugin 'mikewest/vimroom'
Plugin 'bling/vim-bufferline'
Plugin 'gmarik/vundle'
Plugin 'justinmk/vim-sneak'
Plugin 'kien/ctrlp.vim'
Plugin 'kshenoy/vim-signature'
Plugin 'nelstrom/vim-markdown-folding'
" Plugin 'reedes/vim-wordy'
Plugin 'reedes/vim-pencil'
Plugin 'terryma/vim-smooth-scroll'
call vundle#end()

"if has("autocmd")
  "filetype plugin indent on
"endif



execute pathogen#infect()
filetype plugin indent on
syntax enable
"set background=light
"let g:solarized_termcolors=256
"colorscheme solarized
let &t_Co=256
set backspace=indent,eol,start
set autowrite
set dictionary+=/usr/share/dict/words
set display=lastline
set expandtab " tabs are spaces
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" }}}
" Sets and lets {{{

set background=dark            " for syntax highlight in dark backgrounds
" set breakindent               " http://article.gmane.org/gmane.editors.vim.devel/46204
" set showbreak=\.\.\.
" set clipboard=unnamedplus       " Better copy & paste, needs v. 7.3.74+
set columns=125                  " How many columns to display. Works with textwidth to produce right margin.
set nocursorcolumn              " this is the default, but good to know
set nocursorline                " this is the default, but good to know
set encoding=utf-8              " force utf encoding
"set foldcolumn=2                " Add a left margin
set foldlevelstart=0            " Start with folds closed
set foldlevel=99                " Handles code folding.
set hidden                      " Hide buffers when they are abandoned
set history=700                 " length of history
set ignorecase                  " Do case insensitive matching
set laststatus=2                " Needed for powerline / airline eye candy
set list                        " Place a discreet snowman in the trailing whitespace
set listchars=tab:→\ ,trail:☃
set modeline                    " Disabled by default in Ubuntu. Needed for some options.
let loaded_matchparen = 1       " disable matching [{(
set notimeout                   " Time out on key codes but not mappings.
set nowrap                      " disable soft-wrap
set pastetoggle=<F7>
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set regexpengine=2              " use 7.4+ NFA regex for better performance
set ruler                       " This makes vim show the current row and column at the bottom right of the screen.
set scrolloff=9                 " determines #of context lines visible above and below the cursor
set shiftwidth=4
set showcmd                     " Show (partial) command in status line.
set showmode
set smartcase                   " Do smart case matching.
set splitbelow                  " Better split defaults
set splitright
set softtabstop=4
set synmaxcol=800               " Don't try to highlight lines longer than 800 characters.
set t_Co=256                    " set mode to 256 colors
set tabstop=4
" the interplay between columns and textwidth produces the right margin
set textwidth=79                " Auto text wrapping width, 0 to disable. 78 seems to be the default
set ttimeout                    " Time out on key codes but not mappings.
set ttimeoutlen=10              " Related to ttimeout and notimeout
set ttyfast                     " better screen update
set undolevels=700
set wrapmargin=0
set wildmenu                    " Fancy autocomplete after :
set wildmode=longest:full,full




:nnoremap <F3> :OnlineThesaurusCurrentWord<CR>
nnoremap <F4> :setlocal spell! spelllang=en_us<CR>
:nnoremap <F5> "=strftime("%d%m%y%H%M%S")<CR>P
:inoremap <F5> <C-R>=strftime("%d%m%y%H%M%S")<CR>
:map q <esc>            " q enters command mode
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" Disable default online-thesaurus keys
let g:online_thesaurus_map_keys = 0


" }}}
" Custom Functions [from Dennis's dotfiles]{{{

" Display word count on lower right
" http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
function! WordCount()
    let s:old_status = v:statusmsg
    let position = getpos(".")
    exe ":silent normal g\<c-g>"
    let stat = v:statusmsg
    let s:word_count = 0
    if stat != '--No lines in buffer--'
        let s:word_count = str2nr(split(v:statusmsg)[11])
        let v:statusmsg = s:old_status
    endif
    call setpos('.', position)
    return s:word_count
endfunction

set foldtext=CustomFoldText()

" better fold text
" http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
fu! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile

    if fs > v:foldend
        let line = getline(v:foldstart)
        else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 12 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

" evoke these with :call
function! SoftWrap()
    let s:old_fo = &formatoptions
    let s:old_tw = &textwidth
    set fo=
    set tw=999999 " works for paragraphs up to 12k lines
    normal gggqG
    let &fo = s:old_fo
    let &tw = s:old_tw
endfunction

command! Prose call Prose()
" command! Preview :!chromium-browser %<CR>
" command! prose setlocal linebreak nolist wrap wrapmargin=0
command! Code execute "so ~/.vimrc"
function! Prose()

    " autocmd VimResized * if (&columns > 85) | set columns=85 | endif

    " the following automates hardwrap
    " autocmd InsertEnter * set formatoptions+=a
    " autocmd InsertLeave * set formatoptions-=a

    " set columns=80
    " setlocal foldcolumn=0
    " that one needs to be in .vim/after/ftpplugin
    " set formatoptions+=tc
    " setlocal linebreak
    "setlocal nolist
    "setlocal nonumber
    "set showbreak="+++"
    "setlocal textwidth=79

    " use unix par to format paragraphs
    " works better than the built in one
    " setlocal formatprg=par
    "setlocal wrap
    " that one needs to be in .vim/after/ftpplugin
    " set formatoptions+=tc
    "setlocal wrapmargin=0

    " this has to happen after columns are set

    " better navigation for softwrap
    "nnoremap k gk
    "nnoremap j gj
    "nnoremap gk k
    "nnoremap gj j
    "nnoremap 0 g0
    "nnoremap $ g$
    "nnoremap g0 0
    "nnoremap g$ $
    "nnoremap <Space> call SoftWrap()

endfunction END

" }}}

" File types and auto commands {{{

" Force markdown for .md
autocmd BufRead,BufNew *.md set filetype=markdown
autocmd BufRead,BufNew *.md call Prose()

" Spell-check by default for markdown
" autocmd BufRead,BufNewFile *.md setlocal spell
" autocmd FileType markdown set foldmethod=syntax
" autocmd BufRead,BufNew *.md set syntax=OFF

" Set foldmethod to marker for .vimrc
autocmd BufRead,BufNew *.vimrc set foldmethod=marker

" detect YAML front matter for .md
" from wikimatze https://github.com/nelstrom/vim-markdown-folding/issues/3
" not working for now
" autocmd BufRead,BufNewFile *.md syntax match Comment /\%^---\_.\{-}---$/

" Save when losing focus
au FocusLost * :silent! wall

" --- Format Options ---
" :help fo-table
" c= auto-wrap comments to text width
" a= auto-wrap paragraphs
" r= insert comment leader after enter
" o= insert comment leader with 'o'
" use :set formatoptions? to check current defaults
" unset separately, one at a time as done here
" :help fo-table for more infos
au FileType * setlocal formatoptions-=c fo-=o fo+=t fo-=a

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" a mix between syntax and marker folding
" augroup vimrc
"     au BufReadPre * setlocal foldmethod=syntax
"     au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=marker | endif
" augroup END

" Save fold state
" *.* is better than using just *
" when Vim loads it defaults to [No File], which triggers the BufWinEnter,
" and since there is no file name, an error occurs as it tries to execute.
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" place a dummy sign to make sure sign column is always displayed
" otherwise markers work funny
" the autocmd ensures this works for all new buffers
" sign define dummy
" execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" }}}
" Plugin specific stuff {{{

" Markdown folding
let g:markdown_fold_style = 'nested'
let g:markdown_fold_override_foldtext = 0

" Speedup the Pandoc Plugin plugin
let g:pandoc_no_folding = 1
let g:pandoc_no_spans = 1
let g:pandoc_no_empty_implicits = 1
" Least viable modules to get biblio to work. Dont need anything else.
" this plugin is bloated.
let g:pandoc#modules#enabled = ["bibliographies", "completion", "command"]

" Airline / Powerline
let g:airline_theme = 'simple'
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline_detect_modified = 0
let g:bufferline_show_bufnr = 0
" Display wordcount in the section of airline
let g:airline_section_z = '%p%% %{WordCount()} words'

" Custom surrounds for Markdown
let g:surround_98 = "**\r**"

" Disable default online-thesaurus keys
let g:online_thesaurus_map_keys = 0

" Sneak
" replace f/F with sneak
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
xmap f <Plug>Sneak_s
xmap F <Plug>Sneak_S
omap f <Plug>Sneak_s
omap F <Plug>Sneak_S

let g:sneak#streak = 1

" Vimdown
" should the browser window pop-up upon starting Livedown
" let g:livedown_open = 1

" the port on which Livedown server will run
" let g:livedown_port = 8080
" map gm :call LivedownPreview()<CR>

" }}}

" Vimroom Settings
"

let g:vimroom_background = "none"
let g:vimroom_ctermbackground="none"

" Speedup the Pandoc Bundle plugin
let g:pandoc_no_folding = 1
let g:pandoc_no_spans = 1
let g:pandoc_no_empty_implicits = 1
" Least viable modules to get biblio to work. Dont need anything else.
" " this plugin is bloated.
let g:pandoc#modules#enabled = ["bibliographies", "completion", "command"]

" Airline / Powerline
let g:airline_theme = 'simple'
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline_detect_modified = 0
let g:bufferline_show_bufnr = 0
" Display wordcount in the section of airline
let g:airline_section_z = '%p%% %{WordCount()} words'
