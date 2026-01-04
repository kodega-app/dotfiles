-- Minimal Catppuccin Mocha colorscheme configuration
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true, -- Minimal clean look
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = function(colors)
        return {
          -- Make background truly transparent
          Normal = { bg = colors.none },
          NormalFloat = { bg = colors.none },
          NormalNC = { bg = colors.none },
          
          -- Minimal UI elements
          LineNr = { fg = colors.surface2 },
          CursorLineNr = { fg = colors.lavender, style = { "bold" } },
          CursorLine = { bg = colors.surface0 },
          
          -- Clean status line
          StatusLine = { bg = colors.none, fg = colors.text },
          StatusLineNC = { bg = colors.none, fg = colors.surface2 },
          
          -- Minimal telescope
          TelescopeBorder = { fg = colors.surface1 },
          TelescopePromptBorder = { fg = colors.surface1 },
          TelescopeResultsBorder = { fg = colors.surface1 },
          TelescopePreviewBorder = { fg = colors.surface1 },
          
          -- Clean Neo-tree
          NeoTreeNormal = { bg = colors.none },
          NeoTreeNormalNC = { bg = colors.none },
          NeoTreeEndOfBuffer = { fg = colors.base },
          
          -- Minimal popups
          Pmenu = { bg = colors.surface0 },
          PmenuSel = { bg = colors.surface1, fg = colors.text },
          PmenuBorder = { fg = colors.surface1 },
          
          -- Clean git signs
          GitSignsAdd = { fg = colors.green },
          GitSignsChange = { fg = colors.yellow },
          GitSignsDelete = { fg = colors.red },
        }
      end,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = false,
        neotree = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        lsp_trouble = true,
        which_key = true,
        mason = true,
        noice = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        indent_blankline = {
          enabled = true,
          scope_color = "lavender",
          colored_indent_levels = false,
        },
        dashboard = true,
        markdown = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
      
      -- Additional minimal tweaks
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#45475a", bg = "NONE" })
      vim.api.nvim_set_hl(0, "VertSplit", { fg = "#45475a", bg = "NONE" })
    end,
  },
}

