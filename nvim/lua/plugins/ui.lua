-- =============================================================================
-- ui.lua — colorscheme: kanagawa (dark/light follows macOS/GNOME appearance)
-- Wave = dark, Lotus = light
-- =============================================================================

--- Detect macOS/GNOME system appearance.
--- Returns "dark" or "light".
local function get_system_theme()
  if vim.fn.has("mac") == 1 then
    -- macOS: read system appearance via defaults
    local raw = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null"):gsub("%s+", "")
    return (raw == "Dark") and "dark" or "light"
  else
    -- Linux/GNOME: read color-scheme via gsettings
    local raw = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null"):gsub("%s+", "")
    if raw:find("prefer%-dark") then
      return "dark"
    elseif raw ~= "" then
      return "light"
    end
    -- Fallback if gsettings unavailable
    return "dark"
  end
end

--- Read the cached theme written by switch-theme.sh / theme-manager.sh.
--- Falls back to live detection if the file doesn't exist.
local function get_cached_theme()
  local cache_file = vim.fn.expand("~/.cache/theme")
  local f = io.open(cache_file, "r")
  if f then
    local val = f:read("*l"):gsub("%s+", "")
    f:close()
    if val == "dark" or val == "light" then
      return val
    end
  end
  return get_system_theme()
end

--- Apply kanagawa for the given theme ("dark" | "light").
local function apply_theme(theme)
  vim.o.background = theme
  local style = (theme == "dark") and "wave" or "lotus"
  local ok, kanagawa = pcall(require, "kanagawa")
  if ok then
    kanagawa.load(style)
  else
    vim.notify("kanagawa not loaded yet", vim.log.levels.WARN)
  end
end

return {
  -- ── kanagawa (primary, auto dark/light) ──────────────────────────────────
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
          theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {},
          },
        },
        overrides = function(_)
          return {}
        end,
        theme = "wave",  -- default; overridden by apply_theme() below
        background = {
          dark = "wave",
          light = "lotus",
        },
      })

      -- Apply on startup
      apply_theme(get_cached_theme())

      -- ── FocusGained autocmd: re-check theme when nvim regains focus ────────
      vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
        group = vim.api.nvim_create_augroup("ThemeSyncOnFocus", { clear = true }),
        callback = function()
          local new_theme = get_cached_theme()
          if vim.o.background ~= new_theme then
            apply_theme(new_theme)
          end
        end,
        desc = "Sync colorscheme with macOS appearance on focus",
      })
    end,
  },

  -- ── tokyonight (kept available but not active) ────────────────────────────
  {
    "folke/tokyonight.nvim",
    lazy = true, -- only load if explicitly required
    priority = 900,
    opts = {
      style = "storm",
      transparent = false,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
      lualine_bold = true,
    },
  },
}
