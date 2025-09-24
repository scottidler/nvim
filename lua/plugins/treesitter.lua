-- lua/plugins/treesitter.lua

return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- This makes Lazy require the module before applying opts (fixes "module not found")
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },

    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "windwp/nvim-ts-autotag", -- keep if you use autotag
    },

    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "gleam",
        "graphql",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "ocaml",
        "ocaml_interface",
        "prisma",
        "tsx",
        "typescript",
        "vim",
        -- "yaml", -- still flaky upstream
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true, disable = { "ocaml", "ocaml_interface" } },

      -- these only take effect if the companion plugins are installed
      autopairs = { enable = true },
      autotag = { enable = true },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<c-backspace>",
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    },
  },

  -- keep textobjects as a separate spec so Lazy can manage it independently
  { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
}
