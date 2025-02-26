-- Global configuration -----------------------------------

vim.opt.autoindent = true       -- copy indent from current line when starting a new line
vim.opt.autoread = true         -- refresh files when they change
vim.opt.breakindent = true      -- indent lines when they're softwrapped
vim.opt.breakindentopt = { shift = 2, min = 20 } -- settings for breakindent
vim.opt.colorcolumn = '80'      -- show guide for limiting line length
vim.opt.completeopt = { 'menuone' , 'noinsert' } -- always show the menu, no automatic inserting
vim.opt.expandtab = true        -- insert spaces instead of tabs
vim.opt.hlsearch = true         -- highlight search results
vim.opt.ignorecase = true       -- ignore case when searching for lowercase terms
vim.opt.incsearch = true        -- make search results more browser-y
vim.opt.laststatus = 2          -- always show the status line
vim.opt.linebreak = true        -- don't break within words
vim.opt.mouse = 'a'             -- allow clicking on stuff
vim.opt.swapfile = false        -- disable backups
vim.opt.number = true           -- show line numbers
vim.opt.ruler = true            -- show ruler
vim.opt.showmode = false        -- hide default mode label
vim.opt.shiftwidth = 2          -- set width of a tabstop when shifting lines
vim.opt.signcolumn = yes        -- always show status column next to line numbers
vim.opt.smartcase = true        -- don't ignore case when searching for uppercase terms
vim.opt.smartindent = true      -- smart autoindenting for programming (e.g. after {)
vim.opt.smarttab = true         -- insert `shiftwidth` tabs at the beginning of a line
vim.opt.splitbelow = true       -- create new horizontal splits at the bottom
vim.opt.splitright = true       -- create new vertical splits on the right side
vim.opt.switchbuf = { 'useopen' , 'usetab', 'uselast' } -- use tabs for switching buffers, reuse existing
vim.opt.tabstop = 2             -- set width of a tabstop
vim.opt.updatetime = 300        -- snappier updates
vim.opt.wildmenu = true         -- enable better completion
vim.opt.wrap = true             -- softwrap when the text runs longer than the window

-- Plugins ------------------------------------------------

local Plug = vim.fn['plug#']

vim.call('plug#begin')
  -- Editor features
  Plug('airblade/vim-gitgutter')
  Plug('itchyny/vim-gitbranch')
  Plug('maxbrunsfeld/vim-yankstack')
  Plug('ntpeters/vim-better-whitespace')
  Plug('terryma/vim-expand-region')

  -- Languages
  Plug('NoahTheDuke/vim-just')
  Plug('neoclide/jsonc.vim')
  Plug('pangloss/vim-javascript')

  -- Color schemes
  Plug('folke/tokyonight.nvim')
vim.call('plug#end')

-- Color scheme and UI ------------------------------------

vim.opt.laststatus = 3
vim.opt.statusline = "%1* %{mode()} %* %f %M \u{e0a0} %{gitbranch#name()} %= %l:%c %p%% ♥ "

local utils = require("tokyonight.util")
local colors = require("tokyonight.colors").setup()

require("tokyonight").setup({
  style = "night",

  on_highlights = function(hl, colors)
    hl.Search = { fg = colors.orange, bg = utils.blend_bg(colors.orange, 0.15) }
    hl.ExtraWhitespace = { bg = utils.blend_bg(colors.red, 0.25) }
  end
})

vim.cmd('colorscheme tokyonight-night')

function set_statusline_color(mode)
  if mode == 'i' then
    vim.api.nvim_set_hl(0, 'statusline', {
      bg = utils.blend_bg(colors.magenta, 0.15),
      fg = colors.magenta
    })
    vim.api.nvim_set_hl(0, 'user1', {
      bg = colors.magenta,
      fg = colors.bg
    })
  elseif mode == 'r' then
    vim.api.nvim_set_hl(0, 'statusline', {
      bg = utils.blend_bg(colors.red, 0.15),
      fg = colors.red
    })
    vim.api.nvim_set_hl(0, 'user1', {
      bg = colors.red,
      fg = colors.bg
    })
  elseif mode == 'v' then
    vim.api.nvim_set_hl(0, 'statusline', {
      bg = utils.blend_bg(colors.yellow, 0.15),
      fg = colors.yellow
    })
    vim.api.nvim_set_hl(0, 'user1', {
      bg = colors.yellow,
      fg = colors.bg
    })
  elseif mode == 'n' then
    vim.api.nvim_set_hl(0, 'statusline', {
      bg = utils.blend_bg(colors.teal, 0.1),
      fg = colors.teal
    })
    vim.api.nvim_set_hl(0, 'user1', {
      bg = colors.teal,
      fg = colors.bg
    })
  else
    print(string.format('Unstyled mode "%s"', mode))
  end
end

vim.api.nvim_create_autocmd({ 'InsertEnter', 'InsertChange' }, {
  callback = function() set_statusline_color(vim.v.insertmode) end
})

vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function() set_statusline_color('n') end
})

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = { '*:[vV]*' },
  callback = function() set_statusline_color('v') end
})

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = { '[vV]*:[^n]' },
  callback = function() set_statusline_color(vim.v.insertmode) end
})

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = { '[vV]*:n' },
  callback = function() set_statusline_color('n') end
})

set_statusline_color('n')

-- Key mappings -------------------------------------------

vim.g.mapleader = ','

vim.keymap.set('n', '<leader>;', ':tabnew ~/.config/nvim/init.lua<cr>')
vim.keymap.set('n', '<leader><C-t>', ':tabnew<cr>')
vim.keymap.set('n', '<leader>N', ':nohlsearch<cr>')

-- Yankstack
vim.keymap.set('n', '<leader>p', '<Plug>yankstack_substitute_older_paste')
vim.keymap.set('n', '<leader>P', '<Plug>yankstack_substitute_newer_paste')

-- Faster window switching
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- System clipboard access
vim.keymap.set('v', '<leader>c', '\"*y')
vim.keymap.set('v', '<leader>x', '\"*d')
vim.keymap.set('n', '<leader>v', '\"*p')
vim.keymap.set('n', '<leader>V', '\"*P')

-- Terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
