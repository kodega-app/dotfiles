local group = vim.api.nvim_create_augroup("KodeConfig", {
  clear = true,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  callback = function()
    if vim.bo.modifiable and vim.bo.buftype == "" then
      vim.cmd([[%s/\s\+$//e]])
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = {
    "lua",
    "python",
    "javascript",
    "typescript",
    "terraform",
    "yaml",
    "json",
  },
  callback = function()
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})
