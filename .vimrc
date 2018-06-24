" NeoBundle Scripts -----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

  " Required:
  set runtimepath^=~/.vim/bundle/neobundle.vim/

  " Required:
  call neobundle#begin(expand('~/.vim/bundle'))

  " Let NeoBundle manage NeoBundle
  " Required:
  NeoBundleFetch 'Shougo/neobundle.vim'

  " Add or remove your Bundles here:
  NeoBundle 'Shougo/neosnippet.vim'
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'ctrlpvim/ctrlp.vim'
  NeoBundle 'flazz/vim-colorschemes'
  "NeoBundle 'scrooloose/syntastic' "構文エラーチェック
  " ファイルオープンをもっと便利に
  NeoBundle 'Shougo/unite.vim'
  " Unite.vim で最近使ったファイルを表示できるようにする
  NeoBundle 'Shougo/neomru.vim'
  " ファイルをツリー表示してくれる
  NeoBundle 'scrooloose/nerdtree'
  " Rails向けのコマンドを提供する
  NeoBundle 'tpope/vim-rails'
  " Ruby向けにendを自動挿入してくれる
  NeoBundle 'tpope/vim-endwise'
  " コメントON/OFFを手軽に実行
  NeoBundle 'tomtom/tcomment_vim' " Shift+v  -> Ctrl+-を2回
  " インデントに色をつけて見やすくする
  NeoBundle 'nathanaelkane/vim-indent-guides'
  " ログファイルを色付けしてくれる
  NeoBundle 'vim-scripts/AnsiEsc.vim'
  " You can specify revision/branch/tag.
  NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
  " wandbox
  NeoBundle 'rhysd/Wandbox'

  " Required:
  call neobundle#end()

  " Required:
  filetype plugin indent on

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
  " NeoBundleCheck
"End NeoBundle Scripts-------------------------

"--- alias ----
command Tr NERDTree

"--- 基本設定 ---------------------------------
hi LineNr ctermbg=white guifg=#8F908A
" 行番号を表示する
set number
" 編集中のファイル名を表示
set title             
" 括弧入力時の対応する括弧を表示
set showmatch               
" コードの色分け
syntax on     
" インデントスペースを4つ分に設定
set tabstop=4               
" オートインデント
set smartindent 
" 大文字/小文字の区別なく検索する
set ignorecase             
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase            
" 検索時に最後まで行ったら最初に戻る
set wrapscan              
" 文脈によって解釈が異なる全角文字の幅を2に固定
set ambiwidth=double       
" tabを半角スペースで挿入する
set expandtab
" vimが自動で生成するtab幅をスペース4つ分にする
set shiftwidth=4            
set autoindent
" 空白文字の可視化
"set list       
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" 0で始まる数値を8進数として扱わないようにする
set nrformats-=octal       
" ファイルの保存をしていなくても, 別のファイルを開けるようにする
set hidden                
" カーソルが何行目の何列目に置かれているかを表示する
set ruler                 
" エディタウィンドウの末尾から1行目にステータスラインを常時表示させる
set laststatus=3         
" 入力中のコマンドを表示する
set showcmd    
" 文字のないところにカーソル移動できるようにする
set virtualedit=block     
" swapファイルを作らない
set noswapfile
" 検索結果をハイライト表示
set hlsearch
" xtermとscreen対応
set ttymouse=xterm2 
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-h> <C-w><<CR>
nnoremap <S-l> <C-w><CR>
nnoremap <S-k> <C-w>-<CR>
nnoremap <S-j> <C-w>+<CR>
" インサートモードでも移動
" inoremap <c-d> <delete>
" inoremap <c-j> <down>
" inoremap <c-k> <up>
" inoremap <c-h> <left>
" inoremap <c-l> <right>
" ハイライト色設定
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4
set backspace=indent,eol,start
" 全角スペースの表示
function! ZenkakuSpace()
	highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgrey
endfunction
if has('syntax')
	augroup ZenkakuSpace
		autocmd!
		autocmd ColorScheme * call ZenkakuSpace()
		autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace','　')
		augroup END
		call ZenkakuSpace()
endif
" 最後のカーソル位置を復元する
if has("autocmd")
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\ 	exe "normal! g'\"" |
	\ endif
endif
" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
      \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
colorscheme hybrid2


" Unite.vim の設定 ------
"インサートモードで開始
"let g:unite_enable_start_insert=1
"ヒストリー/ヤンク機能を有効化
let g:unite_source_history_yank_enable =1
"prefix keyの設定
nmap <Space> [unite]

"スペースキーとaキーでカレントディレクトリを表示
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"スペースキーとfキーでバッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
"スペースキーとdキーで最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
"スペースキーとbキーでバッファを表示
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
"スペースキーとrキーでレジストリを表示
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
"スペースキーとtキーでタブを表示
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
"スペースキーとhキーでヒストリ/ヤンクを表示
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
"スペースキーとoキーでoutline
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
"スペースキーとENTERキーでfile_rec:!
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>
"unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
    " ESCでuniteを終了
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}

"---- Variables ----
"[wandbox]
" Set default compilers for each filetype
if ! exists('g:wandbox#default_compiler')
    let g:wandbox#default_compiler = {}
endif
let g:wandbox#default_compiler = {
\ 'cpp' : 'clang-head',
\ 'ruby' : 'ruby-1.9.3-p0',
\ }

" Set default options for each filetype. Type of value is string or list of
" string
if ! exists('g:wandbox#default_options')
    let g:wandbox#default_options = {} 
endif
let g:wandbox#default_options = {
\ 'cpp' : 'warning,optimize,boost-1.55',
\ 'haskell' : [
\   'haskell-warning',
\   'haskell-optimize',
\ ],
\ }

" Set extra options for compilers if you need
let g:wandbox#default_extra_options = {
\ 'clang-head' : '-03 -Werror',
\ }

"---- Mappings ----
"[wandbox]
" For all filetypes, use default compiler and options
noremap <Leader>wb :Wandbox<CR>
" For specific filetypes, specify compilers to use
augroup wandbox-settings
    autocmd!
    autocmd Filetype cpp noremap <buffer><Leader>ww :Wandbox --compiler=gcc-head,clang-head<CR>
    autocmd Filetype cpp noremap <buffer><Leader>wg :Wandbox --compiler=gcc-head<CR>
    autocmd FileType cpp noremap <buffer><Leader>wc :Wandbox --compiler=clang-head<CR>
augroup END
