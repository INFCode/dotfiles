vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
local opt = vim.opt

-- display
opt.number = true         -- Make line numbers default (default: false)
opt.relativenumber = true -- Set relative numbered lines (default: false)
opt.wrap = false -- Display lines as one long line (default: true)

-- search
opt.incsearch = true

-- edit
opt.tabstop = 4       -- Insert n spaces for a tab (default: 8)
opt.softtabstop = 4   -- Number of spaces that a tab counts for while performing editing operations (default: 0)
opt.shiftwidth = 4    -- The number of spaces inserted for each indentation (default: 8)
opt.expandtab = true  -- Convert tabs to spaces (default: false)
opt.undofile = true   -- Save undo history (default: false)

-- cursor movement
opt.scrolloff = 5             -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)

-- split windows
opt.splitright = true -- Force all vertical splits to go to the right of current window (default: false)

-- clipboard
opt.clipboard:append({ "unnamedplus" }) -- Sync clipboard between OS and Neovim. (default: '')
