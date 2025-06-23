-- ~/.config/nvim/lua/plugins/trim.lua
return {
  {
    "cappyzawa/trim.nvim",
    opts = {
      -- ft_blocklist = { "markdown" }, -- ignore markdown files
      -- patterns = {
      --  [[%s/\(\n\n\)\n\+/\1/]], -- replace multiple blank lines with a single line
      -- },
      trim_on_write = true,
      trim_trailing = true,
      trim_last_line = true,
      trim_first_line = true,
      highlight = true, -- highlight trailing spaces before removal
      highlight_bg = "#ff0000", -- red background for highlight (or simply 'red')
      highlight_ctermbg = "red",
      notifications = true,
    },
  },
}
