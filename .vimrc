""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" ファイルツリー
Plug 'scrooloose/nerdtree'
" Ruby endキーワード自動挿入
Plug 'tpope/vim-endwise'
" gcで複数行コメントアウト
Plug 'tomtom/tcomment_vim'
" インデントハイライト
Plug 'nathanaelkane/vim-indent-guides'
" 起動時にインデントハイライト自動化
let g:indent_guides_enable_on_vim_startup = 1
" ANSIカラー情報が埋め込まれているファイルを:AnsiEscコマンドでカラー化
Plug 'vim-scripts/AnsiEsc.vim'
" 行末半角スペース可視化
" :FixWhitespeceで削除
Plug 'bronson/vim-trailing-whitespace'
" rails向け
Plug 'tpope/vim-rails'
" 検索用
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" 補完
" python3使用
set pyxversion=3
Plug 'lambdalisue/vim-pyenv'
let g:python3_host_prog = expand('~/.pyenv/shims/python3')
" ヘルスチェック用
Plug 'rhysd/vim-healthcheck'
" Goプラグイン
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" help日本語化
Plug 'vim-jp/vimdoc-ja'
" ヘルプの言語を日本語優先にする
set helplang=ja
" Language Server Protocol
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
let g:lsp_async_completion = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" マルチカーソル
Plug 'terryma/vim-multiple-cursors'
call plug#end()
""""""""""""""""""""""""""""""
"エンコード
set encoding=utf-8
scriptencoding utf-8

"カーソル位置
set ruler
"行番号
set number
" コマンドライン行数
set ch=5

"シンタックス
syntax enable

"オートインデント
set autoindent

"折返し
set wrap

"インデント幅
set shiftwidth=2
set softtabstop=2
set tabstop=2

"タブをスペースに変換
set expandtab
set smarttab

"検索設定
"インクリメンタルサーチ
set incsearch
"ハイライト
set hlsearch
"大文字と小文字を区別しない
set ignorecase
"大文字と小文字が混在した検索のみ大文字と小文字を区別する
set smartcase
"最後尾になったら先頭に戻る
set wrapscan

"不可視文字の設定
set list
set listchars=tab:>-,eol:↲,extends:»,precedes:«,nbsp:%

"入力中のコマンドを表示
set showcmd

"クリップボードの共有
set clipboard=unnamed,autoselect

"エスケープバインド
inoremap <silent> jj <ESC>
"NERDTree設定
nnoremap <silent><C-e> :NERDTreeToggle<CR>
"カラースキーマ
colorscheme murphy
" エディタウィンドウの末尾から2行目にステータスラインを常時表示させる
set laststatus=2
" :makeでの自動保存
set autowrite

" 参考
" http://inari.hatenablog.com/entry/2014/05/05/231307
"""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""

" 括弧補完
inoremap ( ()<ESC>i
inoremap <expr> ) ClosePair(')')
inoremap { {}<ESC>i
inoremap <expr> } ClosePair('}')
inoremap [ []<ESC>i
inoremap <expr> ] ClosePair(']')

function ClosePair(char)
  if getline(".")[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

