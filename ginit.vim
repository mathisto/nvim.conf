if has('win32') || has('win64')
  source ~/AppData/Local/nvim/init.vim
else
  source ~/.config/nvim/init.vim
endif

if exists('g:fvim_loaded')
  " good old 'set guifont' compatibility
  :Guifont DejaVu Sans Mono for Powerline:h13
  " Ctrl-ScrollWheel for zooming in/out
  nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
  nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
  nnoremap <A-CR> :FVimToggleFullScreen<CR>

  FVimFontAntialias v:true
  FVimFontAutohint v:true
  FVimFontSubpixel v:true
  FVimFontLcdRender v:true
  FVimFontHintLevel 'full'
  FVimFontLineHeight '+1.0'
  FVimFontAutoSnap v:true
endif
