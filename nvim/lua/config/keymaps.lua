-- keymaps.lua
-- Additional keymaps on top of LazyVim defaults
local map = vim.keymap.set

-- ── Better window navigation ─────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- ── Resize windows ───────────────────────────────────────────────────────────
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- ── Buffer navigation ────────────────────────────────────────────────────────
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- ── Stay in indent mode in visual ────────────────────────────────────────────
map("v", "<", "<gv", { desc = "Unindent and reselect" })
map("v", ">", ">gv", { desc = "Indent and reselect" })

-- ── Move lines up/down in visual mode ────────────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ── Quick save ───────────────────────────────────────────────────────────────
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- ── Clear search highlight ────────────────────────────────────────────────────
map("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- ── Better paste (don't overwrite register) ───────────────────────────────────
map("v", "p", '"_dP', { desc = "Paste without overwriting register" })

-- ── Yank to system clipboard ──────────────────────────────────────────────────
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- ── Delete without yanking ────────────────────────────────────────────────────
map({ "n", "v" }, "<leader>D", '"_d', { desc = "Delete without yanking" })

-- ── Split windows ─────────────────────────────────────────────────────────────
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal split sizes" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- ── Terminal ──────────────────────────────────────────────────────────────────
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ── Quickfix navigation ───────────────────────────────────────────────────────
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<CR>", { desc = "Prev quickfix" })

-- ── Diagnostics ───────────────────────────────────────────────────────────────
map("n", "<leader>xd", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
