local opt = vim.opt

-- opt.guicursor = "a:xxx"
opt.background = "dark"
opt.selection = "exclusive"
opt.virtualedit = "onemore"
opt.showcmd = false
opt.title = true
opt.titlestring = "%<%F%=%l/%L - nvim"
opt.mousemoveevent = true
opt.syntax = "off"
opt.spelllang = { "en", "vi" }

-- use fold
opt.foldlevelstart = 99
opt.foldlevel = 99
opt.foldenable = true
opt.foldcolumn = "1"
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

opt.viewoptions:remove "curdir" -- disable saving current directory with views
