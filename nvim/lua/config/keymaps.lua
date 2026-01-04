vim.g.mapleader = " "

local keymap = vim.keymap

-- =============================================================================
-- ESSENTIALS
-- =============================================================================
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- =============================================================================
-- WINDOW & TAB MANAGEMENT
-- =============================================================================
-- Splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Buffer Navigation
keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- =============================================================================
-- TERMINAL (TOGGLETERM)
-- =============================================================================
keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle horizontal terminal" })
keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Toggle vertical terminal" })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
  vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
  vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
  vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- =============================================================================
-- OBSIDIAN KNOWLEDGE BASE
-- =============================================================================
-- Workspaces
keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<cr>", { desc = "Switch workspace" })

-- Daily Notes
keymap.set("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Today's daily note" })

-- Note Creation
keymap.set("n", "<leader>on", function()
  require("config.obsidian-helpers").create_note_with_workspace_selection()
end, { desc = "New note" })

keymap.set("n", "<leader>onp", function() require("config.obsidian-helpers").create_note_with_template("project") end, { desc = "New project" })
keymap.set("n", "<leader>onm", function() require("config.obsidian-helpers").create_note_with_template("meeting") end, { desc = "New meeting" })
keymap.set("n", "<leader>onl", function() require("config.obsidian-helpers").create_note_with_template("learning") end, { desc = "New learning" })

-- Search & Navigation
keymap.set("n", "<leader>of",  "<cmd>ObsidianQuickSwitch<cr>", { desc = "Find notes" })
keymap.set("n", "<leader>os",  "<cmd>ObsidianSearch<cr>", { desc = "Search notes" })
keymap.set("n", "<leader>ol",  "<cmd>ObsidianFollowLink<cr>", { desc = "Follow link" })

-- Utilities
keymap.set("n", "<leader>ox", "<cmd>ObsidianToggleCheckbox<cr>", { desc = "Toggle checkbox" })
keymap.set("n", "<leader>oti", "<cmd>ObsidianTemplate<cr>", { desc = "Insert template" })

-- Visual Mode
keymap.set("v", "<leader>ol", "<cmd>ObsidianLink<cr>", { desc = "Link to note" })
