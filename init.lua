local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key
vim.g.mapleader = ' '

require("lazy").setup({
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	-- Library used in some plugins
"nvim-lua/plenary.nvim",
-- Startup Screen
"startup-nvim/startup.nvim",
-- File Explorer
"nvim-tree/nvim-tree.lua",
-- Web Icons
"nvim-tree/nvim-web-devicons",
-- Terminal In Vim
"rebelot/terminal.nvim",
-- Status Line
"nvim-lualine/lualine.nvim",
-- Theme
{"catppuccin/nvim", name="catpuccin-macchiato"},
-- Svelte Syntax Highlightning
"evanleck/vim-svelte",
-- Auto completion (language servers)
{"neoclide/coc.nvim", branch="release"},
-- Tabs
"romgrk/barbar.nvim",
-- File searching
"nvim-telescope/telescope.nvim"
})

require('lualine').setup()
require('startup').setup()
require('nvim-tree').setup({
	renderer = {
		indent_markers= {
			enable = true,
		},
		icons = {
			show = {
				folder = true,
			}
		}
	}
})
require('bufferline').setup({
	sidebar_filetypes = {
		NvimTree = true,
	}
})
require('telescope').setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"-L",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
	},

	extensions_list = { "themes", "terms" },
})

local term_map = require("terminal")
vim.keymap.set("n", "<leader>t", term_map.toggle)
term_map.setup()

-- Default Settings
local command = vim.api.nvim_command
-- Shows line number relative to the current line
command("set relativenumber")
-- Shows line number
command("set number")
-- Theme
command("colorscheme catppuccin-macchiato")
-- Tab size
command("set shiftwidth=4")
-- Tab size
command("set tabstop=4")
-- Language
command("language en")

local map = vim.api.nvim_set_keymap

-- Binding for File Explorer
map('n', '<leader>d','<Cmd>NvimTreeToggle<CR>', {silent = true})

-- Binding for Switching Tabs
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', {noremap=true, silent=true})
map('n', '<A-.>', '<Cmd>BufferNext<CR>', {noremap=true, silent=true})
map('n', '<A-c>', '<Cmd>BufferClose<CR>', {noremap=true, silent=true})

local keyset = vim.keymap.set
local builtin = require('telescope.builtin')

-- intellisense trigger
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], {silent=true, noremap=true, expr=true, replace_keycodes=false})
keyset('i', '<C-s>', "coc#refresh()", {silent=true, expr = true})
keyset("n", "<leader>ca", "<Plug>(coc-codeaction-cursor)", {silent =true, nowait = true})
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent=true})
keyset("n", "<leader>gf", "<Plug>(coc-references)", {silent = true})
keyset("n", "<leader>gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "<leader>gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "<leader>fd", "<Plug>(coc-type-definition)", {silent = true})

-- telescope hotkey
keyset("n", "<leader>ff",builtin.find_files, {})
keyset("n", "<leader>fg",builtin.live_grep, {})

-- Use T to show type of variable
function _G.show_type()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "T", '<CMD>lua _G.show_type()<CR>', {silent = true})

-- SETUP:
-- :CocInstall coc-tsserver coc-json coc-html coc-css coc-pairs @softmotions/coc-svelte
-- :language en
-- need to install "watchman" for Symbol rename working in all files in project
