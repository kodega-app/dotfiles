local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.mouse = "a"

opt.clipboard = "unnamedplus"

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true

opt.signcolumn = "yes"

opt.cursorline = true

opt.conceallevel = 2

opt.wrap = false

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.splitright = true
opt.splitbelow = true

opt.updatetime = 250
opt.timeoutlen = 300

opt.undofile = true

opt.swapfile = false

opt.backup = false

opt.confirm = true

opt.laststatus = 3

opt.showmode = false

opt.list = true
opt.listchars = {
  tab = "→ ",
  trail = "·",
  nbsp = "␣",
}

vim.filetype.add({
  extension = {
    tf = "terraform",
    tfvars = "terraform",
    tofu = "terraform",
    tofutarget = "terraform",
    hcl = "hcl",
    json = "json",
    jsonc = "jsonc",
    json5 = "json5",
    md = "markdown",
    mdx = "markdown",
  },
  filename = {
    [".tflint.hcl"] = "hcl",
  },
})

-- Ensure PATH includes mason bin, mise shims, homebrew paths, Go binaries, and local user bin
local extra_paths = {
  vim.fn.expand("~/.local/share/nvim/mason/bin"),
  vim.fn.expand("~/.local/share/mise/shims"),
  vim.fn.expand("~/go/bin"),
  vim.fn.expand("~/.local/bin"),
  "/opt/homebrew/bin",
  "/opt/homebrew/sbin",
  "/usr/local/bin",
  "/usr/local/sbin",
  "/home/linuxbrew/.linuxbrew/bin",
}

for _, p in ipairs(extra_paths) do
  if vim.fn.isdirectory(p) == 1 and not string.find(vim.env.PATH or "", p, 1, true) then
    vim.env.PATH = p .. ":" .. (vim.env.PATH or "")
  end
end
