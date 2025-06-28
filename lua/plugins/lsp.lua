-- lua/plugins/lsp.lua

return {
  ---------------------------------------------------------------------------
  -- 1. Core LSP setup -------------------------------------------------------
  ---------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- LSP package manager + bridge
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Completion capabilities
      "hrsh7th/cmp-nvim-lsp",

      -- UI status for LSP
      { "j-hui/fidget.nvim", opts = {} },
    },

    config = function()
      ------------------------------------------------------------------------
      -- 1.1 Mason base ------------------------------------------------------
      ------------------------------------------------------------------------
      require("mason").setup({ ui = { border = "rounded" } })

      ------------------------------------------------------------------------
      -- 1.2 Define the servers (lspconfig IDs) ------------------------------
      ------------------------------------------------------------------------
      local servers = {
        bashls = {}, -- Bash
        cssls = {}, -- CSS / SCSS / Less
        html = {}, -- HTML
        jsonls = {}, -- JSON
        pyright = {}, -- Python
        rust_analyzer = {}, -- Rust
        taplo = {}, -- TOML
        yamlls = {}, -- YAML
        ts_ls = { -- JS / TS  (renamed from tsserver)
          settings = { maxTsServerMemory = 12288 },
        },
        lua_ls = { -- Lua (Mason‑managed binary)
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file("", true)),
                },
              },
              telemetry = { enabled = false },
            },
          },
        },
      }

      ------------------------------------------------------------------------
      -- 1.3 Install lists ---------------------------------------------------
      ------------------------------------------------------------------------
      local mason_pkgs = {
        "bash-language-server",
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "pyright",
        "rust-analyzer",
        "taplo",
        "yaml-language-server",
        "typescript-language-server",
        "lua-language-server",
      }

      local lsp_servers = vim.tbl_keys(servers) -- e.g. { "bashls", "cssls", ... }

      require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
        automatic_installation = true,
      })

      require("mason-tool-installer").setup({
        ensure_installed = mason_pkgs,
        auto_update = true,
        run_on_start = true,
        start_delay = 3000, -- ms
        debounce_hours = 12,
      })

      ------------------------------------------------------------------------
      -- 1.4 nvim-lspconfig core --------------------------------------------
      ------------------------------------------------------------------------
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      local default_handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }

      for name, opts in pairs(servers) do
        opts = vim.tbl_deep_extend("force", {
          capabilities = capabilities,
          handlers = default_handlers,
        }, opts)
        require("lspconfig")[name].setup(opts)
      end

      ------------------------------------------------------------------------
      -- 1.5 UI niceties -----------------------------------------------------
      ------------------------------------------------------------------------
      require("lspconfig.ui.windows").default_options.border = "rounded"
      vim.diagnostic.config({ float = { border = "rounded" } })
    end,
  },

  ---------------------------------------------------------------------------
  -- 2. Format‑on‑save helper ----------------------------------------------
  ---------------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      notify_on_error = false,
      format_on_save = {
        async = true,
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        lua = { "stylua" },
      },
    },
  },
}
