require "nvchad.options"

-- add yours here!

local o = vim.o
local opt = vim.opt

o.cmdheight = 1
o.fileencoding = "utf-8" -- the encoding written to a file
o.wrap = false
o.relativenumber = true
-- opt.smartcase = true                        -- smart case
o.smartindent = true -- make indenting smarter again
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.smoothscroll = true

o.expandtab = true -- convert tabs to spaces
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.tabstop = 2 -- insert 2 spaces for a tab
o.cursorline = true -- highlight the current line
o.number = true -- set numbered lines
o.relativenumber = true -- set relative numbered lines
o.numberwidth = 2 -- set number column width to 2 {default 4}
o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
o.wrap = false -- display lines as one long line
o.sidescrolloff = 0
o.scrolloff = 4
o.smoothscroll = true
o.laststatus = 3
o.list = true -- Show some invisible characters (tabs...
o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

o.smartindent = true -- make indenting smarter again
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.swapfile = false -- creates a swapfile
o.termguicolors = true -- set term gui colors (most terminals support this)
o.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)

--- Fold ---
o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99
o.foldcolumn = "1"
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}


-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

vim.cmd("set whichwrap+=<,>,[,]")
vim.cmd([[set iskeyword+=-]])
-- diable open fold with `l`
vim.cmd([[set foldopen-=hor]])

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
