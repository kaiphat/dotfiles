local kommentary = load('kommentary.config')
if not kommentary then return end

kommentary.use_extended_mappings()

kommentary.configure_language("default", {
  prefer_single_line_comments = true,
  ignore_whitespace = true
})
