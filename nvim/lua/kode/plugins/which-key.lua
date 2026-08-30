return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = 300,
    spec = {
      { "<leader>a", group = "AI / Copilot" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code / Actions" },
      { "<leader>e", group = "File Explorer" },
      { "<leader>f", group = "Find / Format" },
      { "<leader>g", group = "Git / Go Tools" },
      { "<leader>o", group = "Obsidian Notes" },
      { "<leader>s", group = "Splits / Windows" },
      { "<leader>u", group = "UI / Toggles" },
      { "<leader>x", group = "Diagnostics / Trouble" },
    },
  },
}

