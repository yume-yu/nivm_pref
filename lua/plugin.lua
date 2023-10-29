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

plugins = {}
table.insert(plugins, require("plugins/base"))
table.insert(plugins, require("plugins/themes"))
table.insert(plugins, require("plugins/ddu"))
table.insert(plugins, require("plugins/ddc"))

require("lazy").setup(plugins)
