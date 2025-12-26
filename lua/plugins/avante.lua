return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
  opts = {
    providers = {
      copilot = {
        model = "claude-sonnet-4.5",
      },
    },
    -- system_prompt as function ensures LLM always has latest MCP server state
    -- This is evaluated for every message, even in existing chats
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ""
    end,
    -- Using function prevents requiring mcphub before it's loaded
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
  },
  dependencies = {
    "nvim-mini/mini.icons",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "ravitemer/mcphub.nvim", -- Ensure mcphub loads before avante
  },
}
