return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  cmd = {
    "Obsidian", "ObsidianToday", "ObsidianYesterday", "ObsidianTomorrow",
    "ObsidianDailies", "ObsidianTemplate", "ObsidianQuickSwitch",
    "ObsidianSearch", "ObsidianBacklinks", "ObsidianFollowLink",
    "ObsidianLinks", "ObsidianOpen", "ObsidianRename",
    "ObsidianToggleCheckbox", "ObsidianPasteImg", "ObsidianTOC",
    "ObsidianTags", "ObsidianWorkspace", "ObsidianExtractNote",
    "ObsidianLink", "ObsidianLinkNew",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    legacy_commands = true,
    workspaces = {
      {
        name = "vault",
        path = vim.fn.expand("~/Documents/workspace/khadga/notes"),
      },
      {
        name = "inbox",
        path = vim.fn.expand("~/Documents/workspace/khadga/notes/0-Inbox"),
        overrides = {
          daily_notes = {
            folder = ".",
          },
        },
      },
      {
        name = "projects",
        path = vim.fn.expand("~/Documents/workspace/khadga/notes/1-Projects"),
      },
      {
        name = "areas",
        path = vim.fn.expand("~/Documents/workspace/khadga/notes/2-areas"),
      },
      {
        name = "resources",
        path = vim.fn.expand("~/Documents/workspace/khadga/notes/3-resources"),
      },
      {
        name = "archive",
        path = vim.fn.expand("~/Documents/workspace/khadga/notes/4-archive"),
      },
    },

    -- Note naming and ID generation
    note_id_func = function(title)
      if title == nil then
        return tostring(os.time())
      end
      return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    end,

    -- PARA & Templates
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {
        yesterday = function() return os.date("%Y-%m-%d", os.time() - 86400) end,
        tomorrow = function() return os.date("%Y-%m-%d", os.time() + 86400) end,
      },
    },

    -- Daily Logging
    daily_notes = {
      folder = "0-Inbox/daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      default_tags = { "daily-notes" },
      template = "daily-note",
    },

    -- Attachments
    attachments = {
      img_folder = "assets",
    },

    -- Robust Frontmatter
    note_frontmatter_func = function(note)
      local out = { id = note.id, aliases = note.aliases or {}, tags = note.tags or {} }
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do out[k] = v end
      end
      return out
    end,
  },
}
