vim.api.nvim_create_augroup('in-terminal', { clear = true })

vim.api.nvim_create_autocmd('TermOpen',
  {
    group = 'in-terminal',
    callback = function()
      vim.opt_local.spell = false
      vim.opt_local.number = false
      vim.opt_local.listchars = {}
      vim.cmd("startinsert")
    end
  }
)

vim.api.nvim_create_autocmd('FileType',
  {
    pattern = 'git*',
    callback = function()
      vim.opt_local.bufhidden = 'wipe'
    end
  }
)
