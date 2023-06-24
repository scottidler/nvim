-- copilot-cmp.lua
return {
  "zbirenbaum/copilot-cmp",
  dependencies = "copilot.lua",
  opts = {},
  config = function(_, opts)
    local copilot_cmp = require("copilot_cmp")
    local cmp = require("cmp")

    -- Set up the copilot_cmp plugin.
    copilot_cmp.setup(opts)

    -- Set up the cmp plugin with the Tab keybinding.
    cmp.setup({
      mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
      },
    })

    -- Attach cmp source whenever copilot attaches.
    -- Fixes lazy-loading issues with the copilot cmp source.
    require("lazyvim.util").on_attach(function(client)
      if client.name == "copilot" then
        copilot_cmp._on_insert_enter({})
      end
    end)
  end,
}
