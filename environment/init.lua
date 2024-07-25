-- ----------------------------------------------------------------------------
-- Global configuration
-- ----------------------------------------------------------------------------

vim.opt.autoindent = true       -- copy indent from current line when starting a new line
vim.opt.autoread = true         -- refresh files when they change
vim.opt.breakindent = true       -- indent lines when they're softwrapped
vim.opt.breakindentopt = { shift = 2, min = 20 } -- settings for breakindent
vim.opt.colorcolumn = '80'      -- show guide for limiting line length
vim.opt.completeopt = { 'menuone' , 'noinsert' } -- always show the menu, no automatic inserting
vim.opt.expandtab = true        -- insert spaces instead of tabs
vim.opt.hlsearch = true         -- highlight search results
vim.opt.ignorecase = true       -- ignore case when searching for lowercase terms
vim.opt.incsearch = true        -- make search results more browser-y
vim.opt.laststatus = 2          -- always show the status line
vim.opt.linebreak = true        -- don't break within words
vim.opt.mouse = 'a'             -- it's 2021 and I want to click on stuff
vim.opt.swapfile = false        -- Disable backups
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

-- ----------------------------------------------------------------------------
-- Plugins
-- ----------------------------------------------------------------------------

local Plug = vim.fn['plug#']

vim.call('plug#begin')
  -- Editor features
  Plug('mattn/emmet-vim')
  Plug('airblade/vim-gitgutter')
  Plug('itchyny/vim-gitbranch')
  Plug('maxbrunsfeld/vim-yankstack')
  Plug('ntpeters/vim-better-whitespace')
  Plug('nvim-lua/plenary.nvim')
  Plug('nvim-lua/popup.nvim')
  Plug('nvim-telescope/telescope.nvim')
  Plug('terryma/vim-expand-region')
  Plug('tpope/vim-commentary')
  Plug('tpope/vim-surround')

  -- Languages
  Plug('neoclide/jsonc.vim')
  Plug('pangloss/vim-javascript')

  -- Color schemes
  Plug('rose-pine/neovim', { ['as'] = 'rose-pine' })
vim.call('plug#end')

-- ----------------------------------------------------------------------------
-- Color scheme and UI
-- ----------------------------------------------------------------------------

vim.opt.laststatus = 3
vim.opt.statusline = "%1* %{mode()} %* %f %M \u{e0a0} %{gitbranch#name()} %= %l:%c %p%% ♥ "

require("rose-pine").setup({
  styles = {
    italic = false
  },

	highlight_groups = {
		StatusLineNC = { fg = "subtle", bg = "surface" },
    ExtraWhitespace = { bg = "love", blend = 40 },
    Search = { fg = 'gold', bg = "gold", blend = 20 },

		TelescopeNormal = { bg = "none" },
		TelescopePromptNormal = { bg = "base" },
		TelescopeResultsNormal = { fg = "subtle", bg = "none" },
		TelescopeSelection = { fg = "text", bg = "base" },
		TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
    TelescopeBorder = { fg = "highlight_high", bg = "none" },

    Comment = { italic = true },
    Conditional = { italic = true },
    Exception = { italic = true },
    Keyword = { italic = true },
    Label = { italic = true },
    Repeat = { italic = true },
    StorageClass = { italic = true },
	},
})

vim.cmd('colorscheme rose-pine-main')

function set_statusline_color(mode)
  local utils = require("rose-pine.utilities")
  local bg = utils.parse_color('base')

  if mode == 'i' then
    vim.api.nvim_set_hl(0, 'statusline', {
      bg = utils.blend(utils.parse_color('iris'), bg, 0.2),
      fg = utils.parse_color('iris')
    })
    vim.api.nvim_set_hl(0, 'user1', {
      bg = utils.parse_color('iris'),
      fg = utils.parse_color('text')
    })
  elseif mode == 'r' then
    vim.api.nvim_set_hl(0, 'statusline', {
      bg = utils.blend(utils.parse_color('love'), bg, 0.2),
      fg = utils.parse_color('love')
    })
    vim.api.nvim_set_hl(0, 'user1', {
      bg = utils.parse_color('love'),
      fg = utils.parse_color('text')
    })
  elseif mode == 'v' then
    vim.api.nvim_set_hl(0, 'statusline', {
      bg = utils.blend(utils.parse_color('gold'), bg, 0.2),
      fg = utils.parse_color('gold')
    })
    vim.api.nvim_set_hl(0, 'user1', {
      bg = utils.parse_color('gold'),
      fg = utils.parse_color('text')
    })
  elseif mode == 'n' then
    vim.api.nvim_set_hl(0, 'statusline', {
      bg = utils.blend(utils.parse_color('pine'), bg, 0.2),
      fg = utils.parse_color('pine')
    })
    vim.api.nvim_set_hl(0, 'user1', {
      bg = utils.parse_color('pine'),
      fg = utils.parse_color('text')
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
  pattern = { '[vV]*:*' },
  callback = function() set_statusline_color('n') end
})

set_statusline_color('n')

-- ----------------------------------------------------------------------------
-- Key mappings
-- ----------------------------------------------------------------------------

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

-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fr', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>ft', telescope.builtin, {})
