" this makes yank copy from cursor pos to EOL
nnoremap Y y$

" better window resize
nnoremap ∆ :resize -2<CR>
nnoremap ˚ :resize +2<CR>
nnoremap ˙ :vertical resize +2<CR>
nnoremap ¬ :vertical resize -2<CR>

" For when you use the laptop's keyboard
inoremap jk <Esc>
inoremap kj <Esc>

" better tabbing
vnoremap < <gv
vnoremap > >gv

" better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" better terminal instantiation
nnoremap <leader>tj <cmd>bo split<CR> <cmd>term<CR> <cmd>res 20<CR> 

" nvim tree commands
nnoremap <leader>fe :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
