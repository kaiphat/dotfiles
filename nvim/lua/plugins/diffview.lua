local diffview = load('diffview')
if not diffview then return end

diffview.setup {
  enhanced_diff_hl = true,
  file_history_panel = {
    win_config = {
      position = 'bottom',
      height = 20,
      win_opts = {}
    },
  }
}
