return {
  -- =============================================================================
  -- GIT TOOLS
  -- =============================================================================
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitFilter" },
    keys = { { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffView File History" },
    },
  },

  -- =============================================================================
  -- KUBERNETES & INFRA
  -- =============================================================================
  {
    "ramilito/kubectl.nvim",
    cmd = { "Kubectl" },
    keys = { { "<leader>k", '<cmd>lua require("kubectl").toggle()<cr>', desc = "Toggle Kubectl" } },
    opts = {},
  },
  {
    "direnv/direnv.vim",
    enabled = vim.fn.executable("direnv") == 1,
  },

  -- =============================================================================
  -- LANGUAGE SPECIFIC (GO & API)
  -- =============================================================================
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function() vim.cmd([[silent! GoInstallDeps]]) end,
    keys = {
      { "<leader>gsj", "<cmd>GoTagAdd json<cr>", desc = "Add JSON tags" },
      { "<leader>gsy", "<cmd>GoTagAdd yaml<cr>", desc = "Add YAML tags" },
      { "<leader>gee", "<cmd>GoIfErr<cr>", desc = "Generate 'if err != nil'" },
    },
  },
  {
    "rest-nvim/rest.nvim",
    ft = { "http" },
    keys = {
      { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run REST request" },
      { "<leader>rl", "<cmd>Rest last<cr>", desc = "Run last REST request" },
    },
  },

  -- =============================================================================
  -- LSP CUSTOMIZATIONS (YAML SCHEMAS)
  -- =============================================================================
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                kubernetes = "*.yaml",
                ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              },
            },
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}

