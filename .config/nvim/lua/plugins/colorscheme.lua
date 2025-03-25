return {

	-- install and configure each individual colorscheme

	-- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = true,
	},

	-- nordic
	{
		"AlexvZyl/nordic.nvim",
		lazy = true,
	},

	-- Actually load a colorscheme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "tokyonight",
		},
	},
}
