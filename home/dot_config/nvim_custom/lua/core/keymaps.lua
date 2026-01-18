local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

map("i", "jk", "<ESC>", default_opts)
map("n", "x", '"_x', default_opts) -- don't pollute the register

-- Moving between tabs
map('n', '<Tab>', ':bnext<CR>', default_opts)
map('n', '<S-Tab>', ':bprevious<CR>', default_opts)

-- Window management
map('n', '<leader>s', '<C-w>v', default_opts) -- split window vertically
map('n', '<leader>sh', '<C-w>s', default_opts) -- split window horizontally

-- Resize splits with Ctrl-arrows
-- TODO: maybe there's a better way?
map('n', '<C-Up>', ':resize -2<CR>', default_opts)
map('n', '<C-Down>', ':resize +2<CR>', default_opts)
map('n', '<C-Left>', ':vertical resize -2<CR>', default_opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', default_opts)
