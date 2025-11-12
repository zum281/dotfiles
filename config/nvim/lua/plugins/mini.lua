return {
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    require('mini.icons').setup({
      style = "glyph"
    })
    require('mini.statusline').setup()
    require('mini.files').setup({
      mappings = {
        close       = 'q',
        go_in       = '<CR>',
        go_in_plus  = 'l',
        go_out      = 'h',
        go_out_plus = 'H',
        mark_goto   = "'",
        mark_set    = 'm',
        reset       = '<BS>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = '=',
        trim_left   = '<',
        trim_right  = '>',
      },

      -- General options
      options = {
        -- Whether to delete permanently or move into module-specific trash
        permanent_delete = true,
        -- Whether to use for editing directories
        use_as_default_explorer = false,
      },
    })
  end
}
