return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    view = {
      width = 32,
      side = "left",
      relativenumber = true,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    filters = {
      dotfiles = false,
    },
    actions = {
      open_file = {
        quit_on_open = false,
        window_picker = {
          enable = false,
        },
      },
    },
  },
}
