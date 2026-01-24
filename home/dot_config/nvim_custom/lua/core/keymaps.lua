local map = _G.Custom.keymap

map("i", "jk", "<ESC>", "Exit Insert Mode")
map("n", "x", '"_x', "Delete Char (No Copy)") -- don't pollute the register

-- Buffer Navigation
map('n', '<Tab>', '<Cmd>bnext<CR>', "Next Buffer")
map('n', '<S-Tab>', '<Cmd>bprevious<CR>', "Prev Buffer")

-- Window management
map('n', '<leader>sv', '<C-w>v', "Split Window Vertically")
map('n', '<leader>sh', '<C-w>s', "Split Window Horizontally")

-- Resize splits with Ctrl-arrows
-- TODO: maybe there's a better way? 'mrjones2014/smart-splits.nvim'?
map('n', '<C-Up>', '<Cmd>resize -2<CR>', "Resize Split Up")
map('n', '<C-Down>', '<Cmd>resize +2<CR>', "Resize Split Down")
map('n', '<C-Left>', '<Cmd>vertical resize -2<CR>', "Resize Split Left")
map('n', '<C-Right>', '<Cmd>vertical resize +2<CR>', "Resize Split Right")
