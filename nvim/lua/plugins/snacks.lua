return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        header = [[
    __ __  ____  ____  __________  ______  ___ 
   / //_/ / __ \/ __ \/ ____/ __ \/ ____/ /   |
  / ,<   / / / / / / / /__  / / / / / __ / /| |
 / /| | / /_/ / /_/ / /___ / /_/ / /_/ // ___ |
/_/ |_| \____/_____/_____/\____/\____//_/  |_|

   ◈ 🚢 DEVOPS ◈ ☁️ CLOUD NATIVE ◈ 🏗️ INFRASTRUCTURE ◈]],
        keys = {
          { icon = "󰄾 ", key = "o", desc = "Obsidian", action = ":Obsidian quick_switch" },
          { icon = "󰉋 ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
          { icon = "󰋚 ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
