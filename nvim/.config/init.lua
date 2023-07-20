-- General settings
vim.opt.wrap = false
vim.opt.switchbuf = "usetab,split"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

-- Set up mouse mode for terminal
vim.opt.mouse = "a"

-- Set things up for COC
vim.cmd [[
  set hidden
  set nobackup
  set nowritebackup
  set updatetime=300
  set shortmess+=c
  set signcolumn=yes
]]

-- Make the command buffer more spacious
vim.cmd [[
  set cmdheight=2
]]

-- Configure vim-better-default plugin.
vim.g.vim_better_default_key_mapping = 1

-- Split more naturally
vim.g.splitbelow = 1
vim.g.splitright = 1

-- Configure Plug and install plugins.
-- Don't forget to run :CocInstall to complete COC setup.
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug 'folke/which-key.nvim'
Plug ('neoclide/coc.nvim', {branch= 'release'})
Plug 'tpope/vim-surround'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'easymotion/vim-easymotion'
vim.call('plug#end')

-- Fugitive: Configure gitlab plugin
vim.g.fugitive_gitlab_domains = {'https://gitlab.svc.maystreet.com/'}

-- Swap ; and :
vim.cmd [[
  nnoremap ; :
  nnoremap : ;
]]

-- Set up terminal mappings
vim.cmd [[
    :tnoremap <Esc> <C-\><C-n>
]]

-- Make it easier to navigate windows and tabs
vim.cmd [[
    :tnoremap <C-h> <C-\><C-N><C-w>h
    :tnoremap <C-j> <C-\><C-N><C-w>j
    :tnoremap <C-k> <C-\><C-N><C-w>k
    :tnoremap <C-l> <C-\><C-N><C-w>l
    :tnoremap <C-H> <C-\><C-N><C-PageDown>
    :tnoremap <C-L> <C-\><C-N><C-PageUp>
    :inoremap <C-h> <C-\><C-N><C-w>h
    :inoremap <C-j> <C-\><C-N><C-w>j
    :inoremap <C-k> <C-\><C-N><C-w>k
    :inoremap <C-l> <C-\><C-N><C-w>l
    :inoremap <C-H> <C-\><C-N><C-PageDown>
    :inoremap <C-L> <C-\><C-N><C-PageUp>
    :nnoremap <C-h> <C-w>h
    :nnoremap <C-j> <C-w>j
    :nnoremap <C-k> <C-w>k
    :nnoremap <C-l> <C-w>l
    :nnoremap <C-H> <C-PageDown>
    :nnoremap <C-L> <C-PageUp>
]]

-- Set up COC
vim.cmd [[
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction


  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  
  
  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif


  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  
  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Make the popup background not suck.
  :hi Pmenu ctermbg=DarkGrey
  :hi FgCocErrorFloatBgCocFloating ctermbg=Red ctermfg=White
  :hi FgCocWarningFloatBgCocFloating ctermbg=DarkGrey ctermfg=Yellow

  " Map [g ]g to jump around diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
]]

-- Set up easymotion search
vim.cmd [[
  map  / <Plug>(easymotion-sn)
  omap / <Plug>(easymotion-tn)
]]

-- Set up leader menus.
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local status, wk = pcall(require, 'which-key')
if not (status) then
    vim.notify('Could not load which-key, skipping mappings.')
    return
end

local wkm = {}

wkm.b = {
	name = 'buffers',
	b = {'<Cmd>Telescope buffers<CR>', 'select a buffer from the list'},
	v = {'<Cmd>rightbelow vsplit<CR><Cmd>Telescope buffers<CR>', 'select a buffer from the list, and open in a new vertical split'},
	h = {'<Cmd>rightbelow split<CR><Cmd>Telescope buffers<CR>', 'select a buffer from the list, and open in a new horizontal split'},
	d = {'<Cmd>bd<CR>', 'close the current buffer'},
	n = {'<Cmd>bn<CR>', 'jump to the next buffer'},
	p = {'<Cmd>bp<CR>', 'jump to the previous buffer'},
}

wkm.c = {
	name = 'code and console',
	c = {'<Cmd>botright split term://fish<CR>i', 'open a terminal console'},
	f = {'<Cmd>call CocAction("format")<CR>', 'format the buffer'},
	r = {'<Plug>(coc-rename)', 'rename the object under the cursor'},
	i = {'<Cmd>CocCommand pyright.organizeimports<CR>', 'organize module imports'},
}

wkm.f = {
	name = 'files',
	f = {'<Cmd>Telescope find_files<CR>', 'find files'},
	v = {'<Cmd>rightbelow vsplit<CR><Cmd>Telescope find_files<CR>', 'find file and open in new vertical split'},
	V = {'<Cmd>vsplit<CR><Cmd>Telescope find_files<CR>', 'find file and open in new vertical split'},
	h = {'<Cmd>rightbelow split<CR><Cmd>Telescope find_files<CR>', 'find file and open in new horizontal split'},
	H = {'<Cmd>split<CR><Cmd>Telescope find_files<CR>', 'find file and open in new horizontal split'},
	s = {'<Cmd>w<CR>', 'save to disk'},
	c = {'<Cmd>rightbelow split $MYVIMRC<CR>', 'load vim initialization file'},
	r = {'<Cmd>source $MYVIMRC<CR>', 'compile vim initialization'},
	n = {
		name = 'new-files',
		s = {'<Cmd>:rightbelow new<CR>', 'split new buffer into window horizontally'},
		v = {'<Cmd>:rightbelow vnew<CR>', 'split new buffer into window vertically'},
	}
}

wkm.g = {
	name = 'git',
	g = {'<Cmd>:G<CR>', 'Open fugitive general buffer'}
}

wkm.j = {
	name = 'jump',
	j = {'<Plug>(easymotion-overwin-f2)', 'Jump the cursor to any point by typing two characters.'},
}

wkm.s = {
	name = 'search',
	f = {'<Cmd>Telescope find_files<CR>', 'find files'},
	g = {'<Cmd>Telescope live_grep<CR>', 'live grep'},
	b = {'<Cmd>Telescope buffers<CR>', 'buffers'},
	h = {'<Cmd>Telescope help_tags<CR>', 'help tags'},
}

wkm.q = {
	name = 'quit',
	q = {'<Cmd>qa<CR>', 'exit editor'},
}

wkm.t = {
	name = 'tabs',
	c = {'<Cmd>tabnew<CR>', 'open a new tab'},
	q = {'<Cmd>tabclose<CR>', 'close the current tab'},
	Q = {'<Cmd>tabclose!<CR>', 'close the current tab with force'},
	o = {'<Cmd>tabonly<CR>', 'close all other tabs but this one'},
	O = {'<Cmd>tabonly!<CR>', 'close all other tabs but this one with force'},
	p = {'<Cmd>tabprevious<CR>', 'go to previous tab (<S-C-left>)'},
	n = {'<Cmd>tabnext<CR>', 'go to next tab (<S-C-right>)'},
	t = {'<Cmd>tabs<CR>', 'show open tabs'},
	P = {'<Cmd>tabmove -<CR>', 'move tab to the left'},
	N = {'<Cmd>tabmove +<CR>', 'move tab to the right'},
}

wkm.w = {
	name = 'windows',
	d = {'<Cmd>q<CR>', 'close current window, quit vim if this is the last window'},
	s = {'<Cmd>rightbelow split<CR>', 'split the current window horizontally'},
	v = {'<Cmd>rightbelow vsplit<CR>', 'split the current window vertically'},
	t = {'<C-W>T', 'move this window to a new tab page'},
	h = {'<Cmd>:wincmd h<CR>', 'jump to the window to the left'},
	j = {'<Cmd>:wincmd j<CR>', 'jump to the window below'},
	k = {'<Cmd>:wincmd k<CR>', 'jump to the window above'},
	l = {'<Cmd>:wincmd l<CR>', 'jump to the window to the right'},
	H = {'<C-PageDown>', 'jump to the tab to the left'},
	L = {'<C-PageUp>', 'jump to the tab to the right'},
}

wk.register(wkm, {prefix = '<leader>'})
