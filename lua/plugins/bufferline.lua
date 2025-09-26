-- lua/plugins/bufferline.lua
return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
      { "catppuccin/nvim", name = "catppuccin" },
    },
    opts = function()
      local highlights
      local ok, cat = pcall(require, "catppuccin.groups.integrations.bufferline")
      if ok and cat and type(cat.get) == "function" then
        highlights = cat.get() -- equivalent to your get_theme wrapper
      end
      return {
        highlights = highlights,
        options = {
          diagnostics = "nvim_lsp",
          separator_style = "slant",
        },
      }
    end,
  },
}
