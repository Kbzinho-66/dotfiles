return {

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        indicator = {
          style = "underline",
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
        enforce_regular_tabs = false,
      },
    },
  },

  -- Only show relative line number when focused
  {
    "sitiom/nvim-numbertoggle",
  },
}
