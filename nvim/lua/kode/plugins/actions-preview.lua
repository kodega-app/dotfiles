return {
  "aznhe21/actions-preview.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  opts = function()
    return {
      backend = { "telescope", "nui" },
    }
  end,
}
