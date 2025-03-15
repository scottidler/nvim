-- lua/config/autocmds.lua

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set up the auto command to run the function when Neovim starts
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    local args = vim.fn.argv()
    local num_args = #args

    if num_args == 2 or num_args == 3 then
      vim.cmd("edit " .. args[1]) -- Open the first file normally
      for i = 2, num_args do
        vim.cmd("vsplit " .. args[i]) -- Open subsequent files in vertical splits
      end
    end
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
