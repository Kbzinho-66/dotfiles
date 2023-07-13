return {
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "amarakon/nvim-cmp-lua-latex-symbols",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        -- Move up and down suggestions
        ["<A-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<A-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      opts.sources = cmp.config.sources(vim.list_extend(
        opts.sources,
        { {
          name = "lua-latex-symbols",
          option = { cache = true },
        } }
      ))
    end,
  },

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

  {
    -- Split and join arguments
    "echasnovski/mini.splitjoin",
  },

  {
    -- Multiple cursors
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    branch = "master",
  },
}
