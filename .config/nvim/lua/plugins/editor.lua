return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>sa", false },

      -- add a keymap to browse plugin files
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
  },

  {
    "folke/flash.nvim",
    opts = {
      mode = "fuzzy",
      modes = {
        char = {
          keys = { "f", "F", "t", "T" },
        },
      },
    },
  },

  -- which-key
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["gz"] = { name = false },
        ["<localleader>s"] = { name = "+surround" },
      },
    },
  },
}
