require("plugins")
vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
local keyset = vim.keymap.set
local command = vim.api.nvim_command

local builtin = require('telescope.builtin')

-- Binding for File Explorer
map('n', '<leader>d','<Cmd>NvimTreeToggle<CR>', {silent = true})

-- Binding for Switching Tabs
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', {noremap=true, silent=true})
map('n', '<A-.>', '<Cmd>BufferNext<CR>', {noremap=true, silent=true})
map('n', '<A-c>', '<Cmd>BufferClose<CR>', {noremap=true, silent=true})

-- This makes the time before it updates your hover faster
-- vim.o.updatetime = 300
-- default value 4000ms

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

-- Default Settings

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
-- Don't prefer alias when renaming
--command("CocCommand typescript.preferences.useAliasesForRename")

-- intellisense trigger
keyset('i', '<c-space>', "coc#refresh()", {silent=true, expr = true})
keyset("n", "<leader>ca", "<Plug>(coc-codeaction-cursor)", {silent =true, nowait = true})
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent=true})
keyset("n", "<leader>gf", "<Plug>(coc-references)", {silent = true})
keyset("n", "<leader>gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "<leader>gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "<leader>fd", "<Plug>(coc-type-definition)", {silent = true})

-- telescope hotkey
keyset("n", "<leader>ff",builtin.find_files, {})
keyset("n", "<leader>fg",builtin.live_grep, {})

-- SETUP:
-- :CocInstall coc-tsserver coc-json coc-html coc-css coc-pairs @softmotions/coc-svelte
-- :language en
-- need to install "watchman" for Symbol rename working in all files in project
