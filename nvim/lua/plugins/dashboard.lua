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
          "       ⚡ AUTOMATION & DEVELOPMENT ENVIRONMENT ⚡",
          "",
        },
        center = {
          {
            icon = "  ",
            icon_hl = "Title",
            desc = "Find File                 ",
            key = "f",
            key_hl = "Number",
            action = "Telescope find_files",
          },
          {
            icon = "󰊄  ",
            icon_hl = "Title",
            desc = "Live Grep                 ",
            key = "g",
            key_hl = "Number",
            action = "Telescope live_grep",
          },
          {
            icon = "  ",
            icon_hl = "Title",
            desc = "Recent Files              ",
            key = "r",
            key_hl = "Number",
            action = "Telescope oldfiles",
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
            icon = "📓 ",
            icon_hl = "Title",
            desc = "Obsidian Notes            ",
            key = "o",
            key_hl = "Number",
            action = "ObsidianSearch",
          },
          {
            icon = "󰒲  ",
            icon_hl = "Title",
            desc = "Plugins (Lazy)            ",
            key = "l",
            key_hl = "Number",
            action = "Lazy",
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
