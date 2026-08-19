-- =============================================================================
-- Centralized Keymaps Configuration
-- All Neovim core & plugin keymaps managed in one central file
-- =============================================================================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- -----------------------------------------------------------------------------
-- 1. Core & File Operations
-- -----------------------------------------------------------------------------
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit Window" })
map("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear Search Highlights" })

-- -----------------------------------------------------------------------------
-- 2. Window Splits & Resizing
-- -----------------------------------------------------------------------------
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split Window Vertically" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split Window Horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make Splits Equal" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close Current Split" })

map("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
map("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- -----------------------------------------------------------------------------
-- 3. Buffer Navigation
-- -----------------------------------------------------------------------------
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete Buffer" })

-- -----------------------------------------------------------------------------
-- 4. Vim & Tmux Navigation (vim-tmux-navigator)
-- -----------------------------------------------------------------------------
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate Left (Tmux/Vim)" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate Down (Tmux/Vim)" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate Up (Tmux/Vim)" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate Right (Tmux/Vim)" })

-- -----------------------------------------------------------------------------
-- 5. File Explorer Sidebar (nvim-tree)
-- -----------------------------------------------------------------------------
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Sidebar File Explorer" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Find Current File in Sidebar" })

-- -----------------------------------------------------------------------------
-- 6. Dashboard Launch Screen (dashboard-nvim)
-- -----------------------------------------------------------------------------
map("n", "<leader>db", "<cmd>Dashboard<CR>", { desc = "Open Dashboard Launch Screen" })

-- -----------------------------------------------------------------------------
-- 6. Telescope Fuzzy Finder
-- -----------------------------------------------------------------------------
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files" })

-- -----------------------------------------------------------------------------
-- 7. Git & LazyGit
-- -----------------------------------------------------------------------------
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- -----------------------------------------------------------------------------
-- 8. Terminal Toggle (ToggleTerm)
-- -----------------------------------------------------------------------------
map({ "n", "t" }, "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

-- -----------------------------------------------------------------------------
-- 9. Formatting (conform.nvim)
-- -----------------------------------------------------------------------------
map({ "n", "v" }, "<leader>fm", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format Buffer or Selection" })

-- -----------------------------------------------------------------------------
-- 10. LSP (Language Server Protocol)
-- -----------------------------------------------------------------------------
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to References" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map({ "n", "v" }, "<leader>ca", function()
  local ok, actions_preview = pcall(require, "actions-preview")
  if ok then
    actions_preview.code_actions()
  else
    vim.lsp.buf.code_action()
  end
end, { desc = "Code Action (with Diff Preview)" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })

-- -----------------------------------------------------------------------------
-- 11. Golang Tools (gopher.nvim)
-- -----------------------------------------------------------------------------
map("n", "<leader>gsj", "<cmd>GoTagAdd json<CR>", { desc = "Add JSON Struct Tags" })
map("n", "<leader>gsy", "<cmd>GoTagAdd yaml<CR>", { desc = "Add YAML Struct Tags" })
map("n", "<leader>grm", "<cmd>GoTagRm<CR>", { desc = "Remove Struct Tags" })
map("n", "<leader>gie", "<cmd>GoIfErr<CR>", { desc = "Generate if err != nil" })
map("n", "<leader>gc", "<cmd>GoCmt<CR>", { desc = "Generate Doc Comment" })

-- -----------------------------------------------------------------------------
-- 12. Obsidian Notes (obsidian.nvim)
-- -----------------------------------------------------------------------------
map("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
map("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "New Obsidian Note" })
map("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian Notes" })
map("n", "<leader>ot", "<cmd>ObsidianToday<CR>", { desc = "Obsidian Today Note" })
map("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Obsidian Backlinks" })
map("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Obsidian Links" })
map("n", "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Obsidian Quick Switch" })
map("n", "<leader>ch", function()
  local ok, obsidian = pcall(require, "obsidian")
  if ok and obsidian.util then
    obsidian.util.toggle_checkbox()
  end
end, { desc = "Toggle Checkbox" })

-- -----------------------------------------------------------------------------
-- 13. Visual Selection Movement & Centered Search
-- -----------------------------------------------------------------------------
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- -----------------------------------------------------------------------------
-- 14. GitHub Copilot & Copilot Chat
-- -----------------------------------------------------------------------------
map({ "n", "v" }, "<leader>cc", "<cmd>CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
map({ "n", "v" }, "<leader>ce", "<cmd>CopilotChatExplain<CR>", { desc = "Explain Code (Copilot)" })
map({ "n", "v" }, "<leader>cf", "<cmd>CopilotChatFix<CR>", { desc = "Fix Code / Bug (Copilot)" })
map({ "n", "v" }, "<leader>ct", "<cmd>CopilotChatTests<CR>", { desc = "Generate Unit Tests (Copilot)" })
map({ "n", "v" }, "<leader>cr", "<cmd>CopilotChatReview<CR>", { desc = "Review Code (Copilot)" })

-- -----------------------------------------------------------------------------
-- 15. Trouble (Diagnostics & Quickfix List)
-- -----------------------------------------------------------------------------
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<CR>", { desc = "Symbols (Trouble)" })
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false<CR>", { desc = "LSP Definitions / References" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })

