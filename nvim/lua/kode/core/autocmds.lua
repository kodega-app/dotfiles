local group = vim.api.nvim_create_augroup("KodeConfig", {
  clear = true,
})

-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Remove trailing whitespace on save (excluding markdown to preserve hard breaks)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  callback = function()
    if vim.bo.modifiable and vim.bo.buftype == "" and vim.bo.filetype ~= "markdown" then
      local view = vim.fn.winsaveview()
      vim.cmd([[%s/\s\+$//e]])
      vim.fn.winrestview(view)
    end
  end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto resize splits when window size changes
vim.api.nvim_create_autocmd("VimResized", {
  group = group,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Close certain transient filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "checkhealth",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true, desc = "Close Buffer" })
  end,
})

-- 2-space indentation filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = {
    "lua",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "jsonc",
    "json5",
    "yaml",
    "html",
    "css",
    "scss",
    "markdown",
    "terraform",
    "hcl",
    "sh",
    "bash",
    "zsh",
  },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- 4-space indentation filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "python" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Tab-based indentation filetypes (Go)
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "go", "gomod", "gowork" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

