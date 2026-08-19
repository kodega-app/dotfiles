return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  config = function()
    require("dashboard").setup({
      theme = "doom",
      config = {
        header = {
          "",
          "  ██╗  ██╗ ██████╗ ██████╗ ███████╗ ██████╗  █████╗ ",
          "  ██║ ██╔╝██╔═══██╗██╔══██╗██╔════╝██╔════╝ ██╔══██╗",
          "  █████╔╝ ██║   ██║██║  ██║█████╗  ██║  ███╗███████║",
          "  ██╔═██╗ ██║   ██║██║  ██║██╔══╝  ██║   ██║██╔══██║",
          "  ██║  ██╗╚██████╔╝██████╔╝███████╗╚██████╔╝██║  ██║",
          "  ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝",
          "",
          "  ⚡ KODEGA AUTOMATION & DEVELOPMENT ENVIRONMENT ⚡",
          "",
        },
        center = {
          {
            icon = "  ",
            icon_hl = "Title",
            desc = "Terminal                  ",
            key = "t",
            key_hl = "Number",
            action = "ToggleTerm",
          },
          {
            icon = "  ",
            icon_hl = "Title",
            desc = "LazyGit Status            ",
            key = "v",
            key_hl = "Number",
            action = "LazyGit",
          },
          {
            icon = "󰒲  ",
            icon_hl = "Title",
            desc = "Plugin Manager (Lazy)     ",
            key = "l",
            key_hl = "Number",
            action = "Lazy",
          },
          {
            icon = "📓 ",
            icon_hl = "Title",
            desc = "Obsidian Notes            ",
            key = "o",
            key_hl = "Number",
            action = "ObsidianSearch",
          },
          {
            icon = "⚙  ",
            icon_hl = "Title",
            desc = "Nvim Configuration        ",
            key = "c",
            key_hl = "Number",
            action = "edit ~/.config/nvim/init.lua",
          },
          {
            icon = "󰩈  ",
            icon_hl = "Title",
            desc = "Quit Neovim               ",
            key = "q",
            key_hl = "Number",
            action = "qa",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local datetime = os.date("📅 %Y-%m-%d  🕒 %H:%M")
          return {
            "",
            "⚡ Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
            datetime,
          }
        end,
      },
    })
  end,
}
