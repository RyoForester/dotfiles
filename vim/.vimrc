"""""""""""""""""""""""""""""""""""""
" dein の自動インストール
"""""""""""""""""""""""""""""""""""""
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" プラグイン読み込み & キャッシュ作成
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールのものがあったらインストール
if dein#check_install()
  call dein#install()
endif


"""""""""""""""""""""""""""""""""""""
" alias 
"""""""""""""""""""""""""""""""""""""
command Tr NERDTree


"""""""""""""""""""""""""""""""""""""
" オプション
"""""""""""""""""""""""""""""""""""""
hi LineNr ctermbg=white guifg=#8F908A
" 行番号を表示する
set number
" 編集中のファイル名を表示
set title             
" 括弧入力時の対応する括弧を表示
set showmatch               
" コードの色分け
syntax on     
" インデントスペースを2つ分に設定
set tabstop=2
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
" vimが自動で生成するtab幅をスペース2つ分にする
set shiftwidth=2
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
" カラースキーマの設定
colorscheme hybrid2

