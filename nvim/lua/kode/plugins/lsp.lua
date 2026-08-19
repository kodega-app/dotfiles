return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local capabilities = cmp_nvim_lsp.default_capabilities()

      mason_lspconfig.setup({
        ensure_installed = {
          "gopls",
          "pyright",
          "ts_ls",
          "terraformls",
          "tflint",
          "jsonls",
          "marksman",
          "dockerls",
          "docker_compose_language_service",
          "yamlls",
          "helm_ls",
          "bashls",
          "lua_ls",
        },
        automatic_installation = true,
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          ["gopls"] = function()
            lspconfig.gopls.setup({
              capabilities = capabilities,
              settings = {
                gopls = {
                  analyses = {
                    unusedparams = true,
                    shadow = true,
                  },
                  staticcheck = true,
                  gofumpt = true,
                  usePlaceholders = true,
                  completeUnimported = true,
                  hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                  },
                  semanticTokens = true,
                },
              },
            })
          end,

          ["pyright"] = function()
            lspconfig.pyright.setup({
              capabilities = capabilities,
              settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "workspace",
                    typeCheckingMode = "basic",
                    autoImportCompletions = true,
                  },
                },
              },
            })
          end,

          ["ts_ls"] = function()
            lspconfig.ts_ls.setup({
              capabilities = capabilities,
              init_options = {
                preferences = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              settings = {
                typescript = {
                  inlayHints = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                  },
                  suggest = {
                    completeFunctionCalls = true,
                  },
                },
                javascript = {
                  inlayHints = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                  },
                  suggest = {
                    completeFunctionCalls = true,
                  },
                },
              },
            })
          end,

          ["terraformls"] = function()
            lspconfig.terraformls.setup({
              capabilities = capabilities,
              filetypes = { "terraform", "terraform-vars", "hcl" },
            })
          end,

          ["tflint"] = function()
            lspconfig.tflint.setup({
              capabilities = capabilities,
            })
          end,

          ["jsonls"] = function()
            lspconfig.jsonls.setup({
              capabilities = capabilities,
              settings = {
                json = {
                  schemas = {
                    {
                      fileMatch = { "package.json" },
                      url = "https://json.schemastore.org/package.json",
                    },
                    {
                      fileMatch = { "tsconfig*.json" },
                      url = "https://json.schemastore.org/tsconfig.json",
                    },
                    {
                      fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
                      url = "https://json.schemastore.org/prettierrc.json",
                    },
                    {
                      fileMatch = { ".eslintrc", ".eslintrc.json" },
                      url = "https://json.schemastore.org/eslintrc.json",
                    },
                  },
                  validate = { enable = true },
                },
              },
            })
          end,

          ["marksman"] = function()
            lspconfig.marksman.setup({
              capabilities = capabilities,
            })
          end,

          ["yamlls"] = function()
            lspconfig.yamlls.setup({
              capabilities = capabilities,
              settings = {
                yaml = {
                  schemas = {
                    kubernetes = "/*.k8s.yaml",
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.yml",
                  },
                  schemaStore = {
                    enable = true,
                  },
                },
              },
            })
          end,

          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
