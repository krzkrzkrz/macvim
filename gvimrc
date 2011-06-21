" This *must* go in .gvimrc, not .vimrc, otherwise the 'macmenu' command
" will be overridden by the one that sets up the default menus.

if has("gui_macvim")
  " Fullscreen takes up entire screen
  " Needed for Command-T. Otherwise, it will rearrange some windows on close
  set fuoptions=maxhorz,maxvert

  " Command-T for CommandT
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
endif
