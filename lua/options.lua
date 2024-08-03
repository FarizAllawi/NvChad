require "nvchad.options"

-- add yours here!

local o = vim.o

o.backup = false -- creates a backup file
o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
o.cmdheight = 0 -- more space in the neovim command line for displaying messages
o.confirm = true -- Confirm to save changes before exiting modified buffer
o.conceallevel = 0 -- so that `` is visible in markdown files
o.fileencoding = "utf-8" -- the encoding written to a file
o.incsearch = true
o.hlsearch = true -- highlight all matches on previous search pattern
o.inccommand = "nosplit"
o.ignorecase = true -- ignore case in search patterns
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"
o.mouse = "a" -- allow the mouse to be used in neovim
o.pumheight = 10 -- pop up menu height
o.showmode = false -- we don't need to see things like -- INSERT -- anymore
o.showtabline = 2 -- always show tabs
-- opt.smartcase = true                        -- smart case
o.smartindent = true -- make indenting smarter again
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.swapfile = false -- creates a swapfile
o.termguicolors = true -- set term gui colors (most terminals support this)
o.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
-- opt.undofile = true                         -- enable persistent undo
o.updatetime = 500 -- faster completion (4000ms default)
o.wildmode = "longest:full,full" -- Command-line completion mode
o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
o.expandtab = true -- convert tabs to spaces
o.shiftwidth = 4 -- the number of spaces inserted for each indentation
o.tabstop = 4 -- insert 2 spaces for a tab
o.cursorline = true -- highlight the current line
o.number = true -- set numbered lines
o.relativenumber = true -- set relative numbered lines
o.numberwidth = 4 -- set number column width to 2 {default 4}
o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
o.wrap = false -- display lines as one long line
o.sidescrolloff = 0
o.scrolloff = 4
o.smoothscroll = true
o.laststatus = 3
o.list = true -- Show some invisible characters (tabs...
o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
-- opt.guicursor = "a:xxx"
o.background = "dark"
o.selection = "exclusive"
o.virtualedit = "onemore"
o.showcmd = false
o.title = true
o.titlestring = "%<%F%=%l/%L - nvim"
o.mousemoveevent = true
o.syntax = "off"
-- use fold
o.foldlevelstart = 99
o.foldlevel = 99
o.foldenable = true
o.foldcolumn = "1"

-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

vim.cmd "set whichwrap+=<,>,[,]"
vim.cmd [[set iskeyword+=-]]
-- diable open fold with `l`
vim.cmd [[set foldopen-=hor]]

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
