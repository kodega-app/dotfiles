return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "auto",
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
      term_colors = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        which_key = true,
        treesitter = true,
        bufferline = true,
        render_markdown = true,
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
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

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
          if vim.o.background ~= target then
            vim.o.background = target
            vim.cmd.colorscheme("catppuccin")
          end
        end
      end

      -- Set theme on startup
      vim.o.background = detect_system_theme()
      vim.cmd.colorscheme("catppuccin")

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
        vim.o.background = new_theme
        vim.cmd.colorscheme("catppuccin")
        local script = vim.fn.expand("~/dotfiles/scripts/theme-manager.sh")
        if vim.fn.executable(script) == 1 then
          vim.fn.jobstart({ script, new_theme, "false" })
        end
        vim.notify(
          "Appearance: Catppuccin " .. (new_theme == "light" and "Latte (Light)" or "Mocha (Dark)"),
          vim.log.levels.INFO
        )
      end, { desc = "Toggle between Dark (Mocha) and Light (Latte) themes across Neovim, Kitty, and Tmux" })
    end,
  },

  {
    "f-person/auto-dark-mode.nvim",
    event = "VeryLazy",
    opts = {
      update_interval = 2000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd("colorscheme catppuccin")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd("colorscheme catppuccin")
      end,
    },
  },


  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        theme = "auto",
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


