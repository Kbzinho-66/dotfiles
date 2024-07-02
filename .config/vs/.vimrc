let mapleader = " "

""" Configurações do VsVim -----------------------------------------------

set vsvim_useeditordefaults

""" Configurações comuns -------------------------------------------------

set ignorecase
set smartcase
set incsearch
set relativenumber

""" Mapeamentos ----------------------------------------------------------

" Deixar o Y consistente com D
map Y y$

" Copiar e colar do clipboard
map <Leader>y "+y
map <Leader>Y "+Y

map <Leader>p "+p
map <Leader>P "+P
map <Leader>p "+p
map <Leader>P "+P

" Navegação
nmap <C-O> :vsc View.NavigateBackward<CR>
nmap <C-I> :vsc View.NavigateForward<CR>
nmap gi :vsc Edit.GoToImplementation<CR>
nmap <Leader><Space> :vsc Edit.GoToAll<CR>

" PeasyMotion
nmap <Leader>f :vsc Tools.InvokePeasyMotion<CR>
nmap <Leader><Tab> :vsc Tools.InvokePeasyMotionJumpToDocumentTab<CR>
nmap <Leader>w :vsc Tools.InvokePeasyMotionLineJumpToWordBegining<CR>
nmap <Leader>e :vsc Tools.InvokePeasyMotionLineJumpToWordEnding<CR>
nmap <Leader>s :vsc Tools.InvokePeasyMotionTwoCharJump<CR>

nmap <Leader>] :vsc Edit.ToggleOutliningExpansion<CR>

"Mostrar o hover
nmap K :vsc Edit.QuickInfo<CR>

"Mappings de refatoração
nmap <Leader>r :vsc Refactor.Rename<CR>
vmap <Leader><lt> :vsc Edit.SortLines<CR>

" Múltiplos cursores
nmap <Leader><C-n> :vsc Edit.InsertCaretsatAllMatching<CR>
nmap <C-n> :vsc Edit.InsertNextMatchingCaret<CR>
nmap <C-p> :vsc Edit.RemoveLastCaret<CR>

" Surround simulating bindings
nnoremap s) ciw(<C-r>")<Esc>
nnoremap s] ciw[<C-r>"]<Esc>
nnoremap s} ciw{<C-r>"}<Esc>
nnoremap s> ciw<lt><C-r>"><Esc>
nnoremap s" ciw"<C-r>""<Esc>
nnoremap s' ciw'<C-r>"'<Esc>

nnoremap sW) ciW(<C-r>")<Esc>
nnoremap sW] ciW[<C-r>"]<Esc>
nnoremap sW} ciW{<C-r>"}<Esc>
nnoremap sW> ciW<lt><C-r>"><Esc>
nnoremap sW" ciW"<C-r>""<Esc>
nnoremap sW' ciW'<C-r>"'<Esc>

" Surround delete bindings
nnoremap ds) vi(dvhp
nnoremap ds] vi[dvhp
nnoremap ds} vi{dvhp
nnoremap ds> vi<dvhp
nnoremap ds" vi"dvhp
nnoremap ds' vi'dvhp

" Surround change bindings
nnoremap cs"' vi"oh<Esc>msvi"l<Esc>cl'<Esc>`scl'<Esc>
nnoremap cs'" vi'oh<Esc>msvi'l<Esc>cl"<Esc>`scl"<Esc>

" Surround visual selected text
vnoremap S" c"<C-r>""<Esc>
vnoremap S' c"<C-r>"'<Esc>
vnoremap S) c(<C-r>")<Esc>
vnoremap S] c[<C-r>"]<Esc>
vnoremap S} c{<C-r>"}<Esc>
vnoremap S> c<lt><C-r>"><Esc>
vnoremap S* c/*<C-r>"*/<Esc>
"vnoremap St c<lt>div><CR><C-r>"<Esc>
" Surround in div tag and edit tag
vnoremap St c<lt>div><CR><C-r>"<Esc>`<lt>lcw
