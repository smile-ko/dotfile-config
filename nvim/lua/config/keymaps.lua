-- local discipline = require("utils.discipline")

-- discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Rest api
keymap.set("n", "<leader>ho", ":Rest open<CR>", opts)
keymap.set("n", "<leader>hr", ":Rest run<CR>", opts)
keymap.set("n", "<leader>hl", ":Rest last<CR>", opts)
keymap.set("n", "<leader>hL", ":Rest logs<CR>", opts)
keymap.set("n", "<leader>hc", ":Rest cookies<CR>", opts)
keymap.set("n", "<leader>he", ":Rest env show<CR>", opts)
keymap.set("n", "<leader>hs", ":Rest env select<CR>", opts)
keymap.set("n", "<leader>hS", ":Rest env set ", opts)

-- Avante
keymap.set("n", "<C-l>", ":AvanteToggle<CR>", opts) -- Toggle sidebar
-- keymap.set("n", "<leader>ua", ":AvanteAsk<CR>", { noremap = true, silent = true }) -- Ask AI
-- keymap.set("n", "<leader>ub", ":AvanteBuild<CR>", { noremap = true, silent = true }) -- Build dependencies
-- keymap.set("n", "<leader>uc", ":AvanteClear<CR>", { noremap = true, silent = true }) -- Clear chat history
-- keymap.set("n", "<leader>uf", ":AvanteFocus<CR>", { noremap = true, silent = true }) -- Switch focus
-- keymap.set("n", "<leader>ur", ":AvanteRefresh<CR>", { noremap = true, silent = true }) -- Refresh window
-- keymap.set("n", "<leader>us", ":AvanteStop<CR>", { noremap = true, silent = true }) -- Stop AI request
-- keymap.set("n", "<leader>up", ":AvanteSwitchProvider<CR>", { noremap = true, silent = true }) -- Switch AI provider
-- keymap.set("n", "<leader>um", ":AvanteShowRepoMap<CR>", { noremap = true, silent = true }) -- Show repo map
-- keymap.set("n", "<leader>ul", ":AvanteModels<CR>", { noremap = true, silent = true }) -- Show list of models
