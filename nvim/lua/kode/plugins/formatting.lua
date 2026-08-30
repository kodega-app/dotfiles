return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      json5 = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      ["markdown.mdx"] = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      less = { "prettier" },
      graphql = { "prettier" },
      go = { "goimports", "gofumpt" },
      terraform = { "terraform_fmt" },
      ["terraform-vars"] = { "terraform_fmt" },
      tofu = { "tofu_fmt" },
      hcl = { "packer_fmt" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
      toml = { "taplo" },
      rust = { "rustfmt" },
    },
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      -- Skip autoformat on save for ignored directories
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("/node_modules/") or bufname:match("/%.git/") then
        return
      end
      return {
        timeout_ms = 1500,
        lsp_format = "fallback",
      }
    end,
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2", "-ci" },
      },
      prettier = {
        ft_parsers = {
          markdown = "markdown",
        },
      },
    },
  },
  init = function()
    -- Format toggle commands
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
        vim.notify("Autoformat-on-save disabled for current buffer", vim.log.levels.WARN)
      else
        vim.g.disable_autoformat = true
        vim.notify("Autoformat-on-save disabled globally", vim.log.levels.WARN)
      end
    end, {
      desc = "Disable autoformat-on-save (use ! for buffer only)",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
      vim.notify("Autoformat-on-save enabled", vim.log.levels.INFO)
    end, {
      desc = "Re-enable autoformat-on-save",
    })

    vim.api.nvim_create_user_command("FormatToggle", function(args)
      if args.bang then
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        local state = vim.b.disable_autoformat and "Disabled" or "Enabled"
        local level = vim.b.disable_autoformat and vim.log.levels.WARN or vim.log.levels.INFO
        vim.notify("Autoformat-on-save (buffer): " .. state, level)
      else
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        local state = vim.g.disable_autoformat and "Disabled" or "Enabled"
        local level = vim.g.disable_autoformat and vim.log.levels.WARN or vim.log.levels.INFO
        vim.notify("Autoformat-on-save (global): " .. state, level)
      end
    end, {
      desc = "Toggle autoformat-on-save (use ! for buffer only)",
      bang = true,
    })
  end,
}

