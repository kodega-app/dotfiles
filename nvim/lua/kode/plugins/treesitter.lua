return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "dockerfile",
      "gitignore",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "helm",
      "hcl",
      "javascript",
      "json",
      "json5",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "terraform",
      "toml",
      "typescript",
      "tsx",
      "vim",
      "vimdoc",
      "yaml",
    },
  },
  config = function(_, opts)
    -- Enable treesitter highlighting for buffers
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("TreesitterAutoStart", { clear = true }),
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

    -- Start on current buffer if already open
    local cur_buf = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_is_valid(cur_buf) and vim.bo[cur_buf].filetype ~= "" then
      pcall(vim.treesitter.start, cur_buf)
    end
  end,
}

