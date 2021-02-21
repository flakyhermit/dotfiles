" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'andreasvc/vim-256noir'
Plug 'itchyny/lightline.vim'
Plug 'danilo-augusto/vim-afterglow'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
colorscheme default

function Prose()
   colorscheme seoul256-light
   set nonumber
   Goyo 130
   Limelight
endfunction
