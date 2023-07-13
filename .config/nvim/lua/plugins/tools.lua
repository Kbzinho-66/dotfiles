return {
  {
    -- Filetype and Syntax plugin for LaTeX
    'lervag/vimtex',
    init = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_quickfix_ignore_filters = {
        'Underfull \\hbox',
        'Overfull \\hbox',
        'Package hyperref Warning: Token not allowed in a PDF string',
      }
    end,
  },

  {
    -- Git wrapper for Vim
    'tpope/vim-fugitive',
  },
}
