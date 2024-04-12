-- lua/plugins/dresssing.lua

return {
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup()
		end,
	},
}
