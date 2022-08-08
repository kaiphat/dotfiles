local zen = load('true-zen')
if not zen then return end

zen.setup {
  modes = {
    ataraxis = {
      padding = {
				left = 52,
				right = 52,
				top = 0,
				bottom = 0,
			},
			quit_untoggles = false,
			minimum_writing_area = {
				width = 40,
				height = 120,
			},
    }
  }
}
