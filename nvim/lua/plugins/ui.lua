return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      sidebars = { "qf", "help", "terminal", "nvim-tree" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = true,
      on_highlights = function(hl, c)
        hl.NormalFloat = { bg = "NONE" }
        hl.FloatBorder = { fg = c.blue, bg = "NONE" }
        hl.FloatTitle = { fg = c.cyan, bg = "NONE", bold = true }
        hl.NvimTreeNormal = { bg = "NONE" }
        hl.NvimTreeNormalNC = { bg = "NONE" }
        hl.NvimTreeWinSeparator = { fg = c.base02 or c.border, bg = "NONE" }
        hl.TelescopeNormal = { bg = "NONE" }
        hl.TelescopeBorder = { fg = c.blue, bg = "NONE" }
        hl.TelescopePromptNormal = { bg = "NONE" }
        hl.TelescopePromptBorder = { fg = c.cyan, bg = "NONE" }
        hl.TelescopeResultsNormal = { bg = "NONE" }
        hl.TelescopeResultsBorder = { fg = c.blue, bg = "NONE" }
        hl.TelescopePreviewNormal = { bg = "NONE" }
        hl.TelescopePreviewBorder = { fg = c.base02 or c.border, bg = "NONE" }
        hl.WhichKeyFloat = { bg = "NONE" }
        hl.WhichKeyBorder = { fg = c.blue, bg = "NONE" }
        hl.LineNr = { fg = c.base01, bg = "NONE" }
        hl.CursorLineNr = { fg = c.blue, bg = "NONE", bold = true }
        hl.SignColumn = { bg = "NONE" }
        hl.FoldColumn = { bg = "NONE" }
        hl.EndOfBuffer = { fg = c.base02, bg = "NONE" }
        hl.WinSeparator = { fg = c.base02 or c.border, bg = "NONE" }
        hl.CopilotSuggestion = { fg = c.base01, italic = true }
      end,
    },
    config = function(_, opts)
      require("solarized-osaka").setup(opts)

      -- Detect system light/dark preference
      local function detect_system_theme()
        -- 1. Check cache file (fastest, zero subshell overhead)
        local cache_file = vim.fn.expand("~/.cache/theme")
        if vim.fn.filereadable(cache_file) == 1 then
          local lines = vim.fn.readfile(cache_file)
          if lines and #lines > 0 then
            local val = vim.trim(lines[1])
            if val == "light" or val == "dark" then
              return val
            end
          end
        end

        -- 2. Check COSMIC desktop setting if present
        local cosmic_file = vim.fn.expand("~/.config/cosmic/com.system76.CosmicTheme.Mode/v1/is_dark")
        if vim.fn.filereadable(cosmic_file) == 1 then
          local lines = vim.fn.readfile(cosmic_file)
          if lines and #lines > 0 then
            local val = vim.trim(lines[1])
            if val == "false" then
              return "light"
            elseif val == "true" then
              return "dark"
            end
          end
        end

        -- 3. Fallback to gsettings
        local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
        if handle then
          local res = handle:read("*a")
          handle:close()
          if res and (res:find("prefer%-light") or res:find("'light'")) then
            return "light"
          elseif res and (res:find("prefer%-dark") or res:find("'dark'")) then
            return "dark"
          end
        end
        return "dark"
      end

      local function apply_theme(target)
        if target and (target == "light" or target == "dark") then
          vim.o.background = target
          pcall(vim.cmd.colorscheme, "solarized-osaka")
        end
      end

      -- Set theme on startup
      local current = detect_system_theme()
      vim.o.background = current
      pcall(vim.cmd.colorscheme, "solarized-osaka")

      -- Real-time reactive theme watcher (inotify via libuv)
      local uv = vim.uv or vim.loop
      local function start_theme_watcher()
        local w = uv.new_fs_event()
        local dir = vim.fn.expand("~/.cache")
        vim.fn.mkdir(dir, "p")
        w:start(
          dir,
          {},
          vim.schedule_wrap(function(err, fname, _)
            if not err and fname and (fname == "theme" or fname:match("^theme")) then
              apply_theme(detect_system_theme())
            end
          end)
        )
      end
      pcall(start_theme_watcher)

      -- Command to toggle theme manually (syncs with Kitty and Tmux)
      vim.api.nvim_create_user_command("ThemeToggle", function()
        local new_theme = vim.o.background == "dark" and "light" or "dark"
        apply_theme(new_theme)
        local script = vim.fn.exepath("theme-manager")
        if script == "" or not script then
          script = vim.fn.expand("~/dotfiles/scripts/theme-manager.sh")
        end
        if vim.fn.executable(script) == 1 then
          vim.fn.jobstart({ script, new_theme, "false" })
        end
        vim.notify("Appearance: Solarized Osaka " .. (new_theme == "light" and "Light" or "Dark"), vim.log.levels.INFO)
      end, { desc = "Toggle between Dark and Light Solarized Osaka themes" })
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        theme = "solarized-osaka",
        globalstatus = true,
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
      },

      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str
            end,
          },
        },
        lualine_b = {
          { "branch", icon = "󰘬" },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
          },
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ●",
              readonly = " 󰌾",
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = "✘ ", warn = "▲ ", info = "» ", hint = "⚑ " },
          },
          { "filetype", icon_only = false },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        mode = "buffers",
        separator_style = "thin",
        always_show_bufferline = false,
        show_buffer_close_icons = true,
        show_close_icon = false,
        color_icons = true,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and "✘ " or "▲ "
          return " " .. icon .. count
        end,
        indicator = {
          style = "icon",
          icon = "▎",
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = "EXPLORER",
            text_align = "center",
            separator = true,
          },
        },
      },
    },
  },
}
