-- general configuration ----------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.breakindent = true
vim.o.breakindentopt = "shift:2,min:20"
vim.o.confirm = true
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.laststatus = 3
vim.o.linebreak = true
vim.o.number = true
vim.o.scrolloff = 5
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.switchbuf = "useopen,usetab,uselast"
vim.o.tabstop = 2
vim.o.winborder = "single"

vim.opt.shortmess:append("I")

-- filetype extras ----------------------------------------

vim.g.markdown_recommended_style = 0

vim.api.nvim_create_autocmd("FileType", {
	desc = "markdown: no indentation on wrapped lines",
	group = vim.api.nvim_create_augroup("markdown-options", { clear = true }),
	pattern = "markdown",
	callback = function()
		vim.opt_local.breakindent = false
	end,
})

-- plugins ------------------------------------------------

-- installed parsers must match nvim-treesitter's version, so update them
-- whenever the plugin itself gets updated
vim.api.nvim_create_autocmd("PackChanged", {
	desc = "update treesitter parsers",

	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	"https://github.com/Aasim-A/scrollEOF.nvim",
	"https://github.com/b0o/SchemaStore.nvim",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/justinmk/vim-sneak",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-mini/mini.ai",
	"https://github.com/nvim-mini/mini.align",
	"https://github.com/nvim-mini/mini.hipatterns",
	"https://github.com/nvim-mini/mini.indentscope",
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/nvim-mini/mini.statusline",
	"https://github.com/nvim-mini/mini.surround",
	"https://github.com/nvim-mini/mini.trailspace",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/stevearc/conform.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

-- appearance ---------------------------------------------

local colors = require("tokyonight.util")

require("tokyonight").setup({
	style = "night",
	on_highlights = function(hl, c)
		hl.TelescopeBorder = { fg = c.fg, bg = c.bg }
		hl.TelescopeNormal = { fg = c.fg, bg = c.bg }
		hl.TelescopePromptBorder = { fg = c.fg, bg = c.bg }
		hl.TelescopePromptTitle = { fg = c.fg, bg = c.bg }
		hl.TelescopeSelection = { bg = colors.blend_fg(c.bg_visual, 0.7, c.bg) }
		hl.TelescopeTitle = { fg = c.fg, bg = c.bg }
		hl.BlinkCmpDocBorder = { fg = c.bg_visual, bg = c.bg_float }
		hl.BlinkCmpMenuBorder = { fg = c.bg_visual, bg = c.bg_float }
		hl.BlinkCmpSignatureHelpBorder = { fg = c.bg_visual, bg = c.bg_float }
		hl.Boolean = { fg = c.blue1 }
		hl.CurSearch = { fg = c.yellow, bg = colors.blend_bg(c.yellow, 0.15, c.bg) }
		hl.CursorLineNr = { fg = c.fg, bold = true }
		hl.FloatBorder = { fg = c.bg_visual, bg = c.bg_float }
		hl.FloatTitle = { fg = c.fg, bg = c.bg_float }
		hl.GitSignsChange = { fg = c.yellow }
		hl.IncSearch = { bg = c.bg_visual }
		hl.MiniHipatternsTodo = { fg = c.blue1, bg = colors.blend_bg(c.blue1, 0.15, c.bg) }
		hl.MiniStatuslineFilename = { fg = c.fg_dark, bg = c.black }
		hl.Search = { bg = c.bg_visual }
		hl.Sneak = { fg = c.yellow, bg = colors.blend_bg(c.yellow, 0.15, c.bg) }
		hl.SneakCurrent = { fg = c.yellow, bg = colors.blend_bg(c.yellow, 0.15, c.bg) }
		hl.TabLineSel = { fg = c.blue, bg = c.bg }
		hl.WhichKeyBorder = { fg = c.border_highlight }
		hl.WhichKeyDesc = { link = "Normal" }
		hl.WhichKeyGroup = { link = "Normal" }
		hl.WhichKeyNormal = { link = "Normal" }
		hl.WhichKeyTitle = { link = "Normal" }
	end,
})

vim.cmd.colorscheme("tokyonight")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank({ higroup = "CursorLine" })
	end,
})

-- editing ------------------------------------------------

require("scrollEOF").setup()

require("mini.pairs").setup()

require("mini.trailspace").setup()

require("mini.align").setup({ mappings = { start = "&" } })

-- ai
local ai_spec = require("mini.ai").gen_spec

require("mini.ai").setup({
	custom_textobjects = {
		c = ai_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
		f = ai_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
	},
	mappings = { around_next = "aN", inside_next = "iN", around_last = "aL", inside_last = "iL" },
})

-- patterns
require("mini.hipatterns").setup({
	highlighters = {
		todo = { pattern = "%f[%w]()TODO:()", group = "MiniHipatternsTodo" },
	},
})

-- indentscope
local indentscope = require("mini.indentscope")

indentscope.setup({
	draw = {
		predicate = function()
			return false
		end,
	},
	mappings = { object_scope = "", object_scope_with_border = "" },
	options = { indent_at_cursor = false },
})

local function select_indent(border)
	return function()
		local default = indentscope.config.options.border
		indentscope.config.options.border = border
		pcall(indentscope.textobject, border ~= "none")
		indentscope.config.options.border = default
	end
end

vim.keymap.set({ "x", "o" }, "ii", select_indent("none"), { desc = "indent level" })
vim.keymap.set({ "x", "o" }, "ai", select_indent("top"), { desc = "indent level and line before" })
vim.keymap.set({ "x", "o" }, "aI", select_indent("both"), { desc = "indent level and lines around" })

-- surround
require("mini.surround").setup({
	mappings = {
		add = "gz",
		delete = "gsd",
		find = "",
		find_left = "",
		highlight = "",
		replace = "gsr",
		suffix_last = "",
		suffix_next = "",
	},
	search_method = "cover_or_next",
})

vim.keymap.del("x", "gz")
vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], { silent = true, desc = "surround selection" })

-- which-key ----------------------------------------------

require("which-key").setup({
	delay = 0,
	icons = { group = "› ", mappings = false, separator = " " },
	layout = { width = { min = 0.6 } },
	show_help = false,
	win = {
		border = "single",
		col = math.huge,
		no_overlap = false,
		row = -1,
		title_pos = "left",
		width = { max = 100, min = 30 },
		height = { max = 30 },
	},
})

-- status line --------------------------------------------

local statusline = require("mini.statusline")

statusline.setup({
	content = {
		active = function()
			local mode, mode_hl = statusline.section_mode({})
			mode = mode:sub(1, 3):upper()
			local mode_group = { hl = mode_hl, strings = { mode } }

			local filename_group = { hl = "MiniStatuslineFilename", strings = { "%f %m" } }
			local col_group = { hl = "MiniStatuslineFilename", strings = { "%l:%c" } }

			return statusline.combine_groups({ mode_group, filename_group, "%=", col_group })
		end,
	},
})

-- telescope ----------------------------------------------

require("telescope").setup({
	defaults = {
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		mappings = { i = { ["<Esc>"] = require("telescope.actions").close } },
	},
	pickers = {
		-- all files including hidden ones, but still respecting .gitignore
		find_files = { find_command = { "rg", "--files", "--hidden", "--glob=!.git", "--color=never" } },
		live_grep = { additional_args = { "--hidden", "--glob=!.git" } },
	},
})

require("telescope").load_extension("ui-select")

vim.keymap.set("n", "<leader>'", "<cmd>Telescope resume<CR>", { desc = "open last picker" })
vim.keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<CR>", { desc = "global search in workspace" })
vim.keymap.set("n", "<leader>?", "<cmd>Telescope commands<CR>", { desc = "open command palette" })
vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics<CR>", { desc = "open workspace diagnostic picker" })
vim.keymap.set("n", "<leader>S", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "open workspace symbol picker" })
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>", { desc = "open buffer picker" })
vim.keymap.set("n", "<leader>d", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "open diagnostic picker" })
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>", { desc = "open file picker" })
vim.keymap.set("n", "<leader>g", "<cmd>Telescope git_status<CR>", { desc = "open changed file picker" })
vim.keymap.set("n", "<leader>h", "<cmd>Telescope lsp_references<CR>", { desc = "select symbol references" })
vim.keymap.set("n", "<leader>j", "<cmd>Telescope jumplist<CR>", { desc = "open jumplist picker" })
vim.keymap.set("n", "<leader>s", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "open symbol picker" })

-- gitsigns -----------------------------------------------

local gitsigns = require("gitsigns")

gitsigns.setup()

local function unless_diff(keys, action)
	return function()
		if vim.wo.diff then
			vim.cmd.normal({ keys, bang = true })
		else
			action()
		end
	end
end

vim.keymap.set( "n", "]c", unless_diff("]c", function() gitsigns.nav_hunk("next") end), { desc = "next git change" })
vim.keymap.set( "n", "[c", unless_diff("[c", function() gitsigns.nav_hunk("prev") end), { desc = "previous git change" })
vim.keymap.set("n", "<leader>Go", gitsigns.preview_hunk_inline, { desc = "expand git change" })
vim.keymap.set("n", "<leader>Gu", gitsigns.reset_hunk, { desc = "restore git change" })
vim.keymap.set("n", "<leader>GO", gitsigns.stage_hunk, { desc = "toggle git change staged" })

-- treesitter ---------------------------------------------

local ts_languages = {
  "css", "go", "gomod", "html", "java", "javascript", "json", "toml", "tsx",
  "typescript", "vue", "yaml",
}

require("nvim-treesitter").install(ts_languages)

vim.api.nvim_create_autocmd("FileType", {
	desc = "enable treesitter highlighting",
	group = vim.api.nvim_create_augroup("treesitter", { clear = true }),

	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		if vim.list_contains(ts_languages, lang) then
			pcall(vim.treesitter.start, ev.buf, lang)
		end
	end,
})

vim.keymap.set("n", "<M-Up>", "van", { remap = true, desc = "select larger syntax node" })
vim.keymap.set("x", "<M-Up>", "an", { remap = true, desc = "select larger syntax node" })
vim.keymap.set("x", "<M-Down>", "in", { remap = true, desc = "select smaller syntax node" })

-- function/class motions like zed, text objects for these are set up in mini.ai
local ts_move = require("nvim-treesitter-textobjects.move")

local function ts_goto(fn, captures)
	return function()
		ts_move[fn](captures, "textobjects")
	end
end

local ts_section = { "@class.outer", "@function.outer" }

vim.keymap.set({ "n", "x", "o" }, "]m", ts_goto("goto_next_start", "@function.outer"), { desc = "next function" })
vim.keymap.set({ "n", "x", "o" }, "[m", ts_goto("goto_previous_start", "@function.outer"), { desc = "previous function" })
vim.keymap.set({ "n", "x", "o" }, "]M", ts_goto("goto_next_end", "@function.outer"), { desc = "next function end" })
vim.keymap.set({ "n", "x", "o" }, "[M", ts_goto("goto_previous_end", "@function.outer"), { desc = "previous function end" })
vim.keymap.set({ "n", "x", "o" }, "]]", ts_goto("goto_next_start", ts_section), { desc = "next class or function" })
vim.keymap.set({ "n", "x", "o" }, "[[", ts_goto("goto_previous_start", ts_section), { desc = "previous class or function" })

-- lsp ----------------------------------------------------

vim.lsp.config("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

-- lspconfig only starts oxlint in projects with an oxlint config by default
vim.lsp.config("oxlint", {
	root_dir = function(bufnr, on_dir)
		on_dir(vim.fs.root(bufnr, { ".oxlintrc.json", "package.json", ".git" }) or vim.fn.getcwd())
	end,
})

vim.lsp.enable({ "cssls", "gopls", "html", "jsonls", "marksman", "oxlint", "tsc" })

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "lsp keymaps",
	group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
	callback = function(ev)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "go to definition" })
		vim.keymap.set("n", "gh", vim.diagnostic.open_float, { buffer = ev.buf, desc = "show diagnostic under cursor" })
		vim.keymap.set({ "n", "x" }, "g.", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "open code actions" })
	end,
})

local diagnostic_icons = {
	[vim.diagnostic.severity.ERROR] = "✗",
	[vim.diagnostic.severity.WARN] = "▲",
	[vim.diagnostic.severity.INFO] = "→",
	[vim.diagnostic.severity.HINT] = "●",
}

vim.diagnostic.config({
	virtual_text = {
		prefix = function(diagnostic)
			return diagnostic_icons[diagnostic.severity]
		end,
	},
	signs = { text = diagnostic_icons },
})

-- formatting ---------------------------------------------

require("conform").setup({
	formatters_by_ft = {
		css = { "oxfmt" },
		go = { "gofmt" },
		graphql = { "oxfmt" },
		handlebars = { "oxfmt" },
		html = { "oxfmt" },
		javascript = { "oxfmt" },
		javascriptreact = { "oxfmt" },
		json = { "oxfmt" },
		jsonc = { "oxfmt" },
		markdown = { "oxfmt" },
		toml = { "oxfmt" },
		typescript = { "oxfmt" },
		typescriptreact = { "oxfmt" },
		vue = { "oxfmt" },
		yaml = { "oxfmt" },
	},
	format_on_save = { timeout_ms = 1000 },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = { start = { args.line1, 0 }, ["end"] = { args.line2, end_line:len() } }
	end
	require("conform").format({ async = true, range = range })
end, { range = true, desc = "format buffer or range" })

-- completion ---------------------------------------------

require("blink.cmp").setup({
	completion = {
		documentation = { auto_show = true },
		list = { selection = { preselect = false, auto_insert = true } },
	},
	keymap = {
		preset = "enter",
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
	},
})

-- keymap -------------------------------------------------

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("x", "<leader>y", '"+y', { desc = "yank selection to clipboard" })
vim.keymap.set("x", "<leader>d", '"+d', { desc = "delete selection to clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "paste from clipboard after cursor" })
vim.keymap.set({ "n", "x" }, "<leader>P", '"+P', { desc = "paste from clipboard before cursor" })
