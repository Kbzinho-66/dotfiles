return {
	{
		-- Surround text objects
		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "<localleader>sa", -- Add surrounding in Normal and Visual modes
				delete = "<localleader>sd", -- Delete surrounding
				find = "<localleader>sf", -- Find surrounding (to the right)
				find_left = "<localleader>sF", -- Find surrounding (to the left)
				highlight = "<localleader>sh", -- Highlight surrounding
				replace = "<localleader>sr", -- Replace surrounding
				update_n_lines = "<localleader>sn", -- Update `n_lines`
			},
		},
	},
}
